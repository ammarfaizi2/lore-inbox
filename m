Return-Path: <linux-kernel-owner+w=401wt.eu-S1760326AbWLKESQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760326AbWLKESQ (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 23:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760328AbWLKESQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 23:18:16 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:47740 "EHLO
	e34.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760324AbWLKESP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 23:18:15 -0500
Message-ID: <457CDC38.2090907@us.ibm.com>
Date: Sun, 10 Dec 2006 22:19:04 -0600
From: Steve French <smfltc@us.ibm.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: akpm@osdl.org, linux-kernel <linux-kernel@vger.kernel.org>,
       Shirish S Pargaonkar <shirishp@us.ibm.com>, simo <simo@samba.org>,
       Jeremy Allison <jra@samba.org>, linux-cifs-client@lists.samba.org
Subject: Re: -mm merge plans for 2.6.20
References: <200612092220_MC3-1-D483-92AE@compuserve.com>
In-Reply-To: <200612092220_MC3-1-D483-92AE@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
> In-Reply-To: <4579AFA5.90003@us.ibm.com>
>
> On Fri, 08 Dec 2006 12:32:05 -0600, Steve French wrote:
>
>   
>> smbfs deprecation is ok but there are a few things to consider:
>>     
>
> How well-tested is the plaintext password support?
>
> By default the /proc/fs/cifs/SecurityFlags setting is 0x7 (MAY_SIGN |
> MAY_NTLM | MAYNTLMV2). Trying to connect to an old Samba server
> with that, I got a message that the server requested a plain text
> password but client support was disabled.
>
> After changing the flags to 0x37 (adding MAY_LANMAN | MAY_PLNTXT),
> I got "invalid password." Looking at the ethereal traces, it seemed
> that the password was being sent as encrypted Unicode, and the only
> way to make it connect was to set the flags to 0x30.
>   
I don't remember any problems reported with plain text password
support on current cifs and I have certainly seen it negotiated with no 
problem,
but I will double check with your reported flag combination.
> Also, the client doesn't automatically pick up the domain name from
> smb.conf like smbfs does.
>
>   
That is true, and is intentional.   cifs sends a domain of null (ie use 
the server's
default domain) - but it can be overridden on mount
