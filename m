Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbUBZPzq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 10:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262548AbUBZPzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 10:55:46 -0500
Received: from mailgate.wolfson.co.uk ([194.217.161.2]:45817 "EHLO
	wolfsonmicro.com") by vger.kernel.org with ESMTP id S262515AbUBZPzm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 10:55:42 -0500
Subject: Re: [BUG] unsafe reset in ac97_codec.c
From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1076003988.15801.8.camel@dhcp23.swansea.linux.org.uk>
References: <1075822947.5204.506.camel@cearnarfon>
	 <40216306.2010602@pobox.com>  <1075998717.5204.1003.camel@cearnarfon>
	 <1076003988.15801.8.camel@dhcp23.swansea.linux.org.uk>
Content-Type: multipart/mixed; boundary="=-68D6gq7Uy2EU3PfIZS1x"
Message-Id: <1077810934.2846.187.camel@cearnarfon>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 26 Feb 2004 15:55:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-68D6gq7Uy2EU3PfIZS1x
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi

I've attached a patch against 2.4.25 that now checks for the codec type
before doing the AC97 register reset.

Changes:-

 o Added AC97_DEFAULT_POWER_OFF to ac97_codec_ids[]
 o ac97_probe now checks hardwired codec ID's before sending a reset
 o Added initial support for WM9713 AC97 codec.


Liam

On Thu, 2004-02-05 at 17:59, Alan Cox wrote:
> On Iau, 2004-02-05 at 16:31, Liam Girdwood wrote:
> > I agree, but I think we need to be aware of the codec type before we do
> > a register reset. This type of codec is now becoming popular in PDA's.
> 
> Sometimes we can't even find out but yes I agree
> 
> > I can see another problem with the current probe implementation.
> > Currently it sends the register reset command without first checking the
> > codec ready bit. This assumes that the AC97 link is up and completely
> > working before probe is called.
> 
> It is (in theory) the job of the calling driver to ensure AC97 is up
> before doing the reset part.
> 
> > I'll implement this if it's acceptable as I can test it on both types of
> > codec.
> 
> Sounds right to me
> 
> 
> ________________________________________________________________________
> This email has been scanned for all viruses by the MessageLabs Email
> Security System. 
> ________________________________________________________________________
> 

--=-68D6gq7Uy2EU3PfIZS1x
Content-Disposition: attachment; filename=ac_power.diff.gz
Content-Type: application/x-gzip; name=ac_power.diff.gz
Content-Transfer-Encoding: base64

H4sICB8UPkAAA2FjX3Bvd2VyLmRpZmYArVhtc9o4EP5sfsWWm8tADcEyJrz0LUzitJkLIQNJ27u5
GY9ji6CrsTm/lORy/e+3K5nEQEPS9JjExpaeR9LuPrtCvphMoJ7Fp+A2/Fh85XHSSKIs9Buu1207
XuRzb9eDyy2NpXq9vhWtmYbRrDNWNzvAOj1zr2cau8byAzpdS7qubx2FSKy6YdbNFjDWszo9xjZI
9veh3jRqe6DjtQv7+yWAl//bh8joHz6IJI3im5KO34/4JZitGtD04ES4M3gvYn8RRb5shr7vcx+S
bD6P4hQmUQxyQQmkUzeFmP+diZiDCws3nuFjwlNII5hHCx5DNt9VJOMC/NOg22ZNOY+BewOGKcdu
ro4NrwN83L3KH/cXUTBJonAmvDja9aLZW8JrIz6LvuLswigEfo2LcsNU8qMpqX1z7rIRVyvvnfze
VXdm5Hcm/dBm5Ie2VWtLPyB5KjwQOEI+GUeEIjWsSpLGmZfCvbNxZfJeffUwrPUsGGNbYfpDsOaT
R0tjkXJvKmE/DJq5HCHRj4ETcTVzUx445JEHoUskeYYZbXINY2zVN0VYNE/uTIDfMbbfwO2a52pw
enFyoq7w7dWTeFqbPK1n8DC2wYOrWePRn8DT3ORpPnU+S7fRd2Ip+v5HOWYbLMVgeCrbaiwsGTcj
ZJ1PRsVeR0ZFu5lHhXZrXLfa1qF1QC4qf1I2ylNAQym+XAOAnRUHf6utQLvr0G65pmk7YRYE1H+1
NzPXejPWwIuJkJ0V7yNML8Ca67DmOgJ79A/QSof2Uf/i5Nw5G36yR87w6Gg5gU6zY7X3DMxh5THZ
65wHMD7vH7zDD5GtTzjvb633xxWyRrNhNVpom4dQre+grLVRZA7tNmUS7Xbvqpl2kMUxD9PgRmUD
Z+GKFEQCWYK5GkuHfKZcTayqj8Td1RZM//OAp3wXZEFTBSaa8WVhWoggyAuQHy1CWEx5iAUq5ldY
IfClIhKJQs55jIPNuL8LnzhWkgV4U+59kTNIMm+as8pClhedNIvDBBhUMHp5FdBn2NHjSVIDBBlQ
mbhBohomrgiymO8SsoEXaZUOhomJZumYrMYsFatUiY8/D+wemSKdchw/CKKFCK9ovTM0GERZ6qMM
/HcA9b+u3Pgf8QUU8iyOLqlnNFFGEyFSIM8C6yvewogKNRbUy4DXQFmb3vGvaJhx/8iGFy8kUaNU
1+Ry629z35CWK/J7Hn8je2yf18A4oSyO3RsvARcboYS9KPZpEuihZE79F/zel4o15q5/I7XPcTAN
JfATcJyxmEBldb4IqGKDtvG2cld6NI7OoT6ZzwP3psIMfFvHpRBbxc18EWHWWSGggTetUK3CDqAk
cONWhVsk0OYxFrQvld/s0aljj0ZQvq9gPfg1kXlOMUv7zykSw/TPsFwjNKjPckXCl/RmFd4V3u0w
fCxb6bQMPSif8zgVbnxTrkKBobfRf8y9KPSpYw+gfBaLmQTRwjUUFgU0GPTwTVoCvTLHkOLS9gOk
msGBKsOFCJnJ92/yKk2aceSrO0vf9QxdFOcbmaxfrUeYyvE7Pp+4WZDSIzlDz2NDSpnUoIxWEDU6
a03Q7/KY8Nmj7vtonx4OR87xIZMBIXzz6RBTQsgwFYEo4xUIeA390aj/uzM+/sOu3PvcEX5SxXZd
p/iQyreatQ4K3zJqZl6kNO0SB/tCpGh9kB6Aoo0DHKVCq3r9GtheFf4FnC9uDorRPwncqwRevHmg
RtDwukYGVaZS1nRD/15hZGSlr0t8c8nxHScJYtykIsyk4PR1XW3NDtj7AX1iyxaBYqtUKPUqSlRH
0+j5sn9CpvpPyVT/aZnqz5KpXpTp0hLbZKo/Wab6d2WqPy5T0EgIjzrB/nyO2rEPHdwnnF+MleIm
lQmazarm+/lOS23oDSyIe0oX98sFlEVJx8WqnZFc3XN+6JT02/VlbUbwoD8+R9F8HJ449MUeYjRf
02/z6oZNNsEf7P7h2YfhqU34eyA8jhzZB8PRofO+f3yqcC7itMdxyrjOYHhoD6SBV6ZbCBmKmGf8
ziuhYmDLJDDw9+SQTTmkXziNEaEXoH4bAaaP6+JRyBQutzTmpzEPd1CnMUZHHqSYPcvCv5WDFHZ3
GrOdRJ3G7AFr9cx2r7V5pEOxaXblcQzd8oRdgl9QBiLky2R7ckHRLV2gMRJlXyYnZciY09lDgrsu
zCugxEh1aoXjdOicHQwoaC4GtmYSx8coyGYq/cZRQDu2mUgS2iBR+iAJrM1iLeWDBcgyWi2RhZ2x
3B/KSkqzoZ9kJeDX2DWU4SFtRVJ2MMN4mKimbgwv5+4Vd3AbWgP1/BIDKsanaDJxUrrWSv8Bt7XP
BJATAAA=

--=-68D6gq7Uy2EU3PfIZS1x--

