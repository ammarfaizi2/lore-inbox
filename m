Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311245AbSCQBhN>; Sat, 16 Mar 2002 20:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311244AbSCQBhD>; Sat, 16 Mar 2002 20:37:03 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:11012 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S311241AbSCQBg4>;
	Sat, 16 Mar 2002 20:36:56 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Petko Manolov <pmanolov@lnxw.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: debugging eth driver 
In-Reply-To: Your message of "Sat, 16 Mar 2002 10:52:10 -0800."
             <3C93945A.8040305@lnxw.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 17 Mar 2002 12:36:43 +1100
Message-ID: <25257.1016329003@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Mar 2002 10:52:10 -0800, 
Petko Manolov <pmanolov@lnxw.com> wrote:
>Alan Cox wrote:
>>>How am i supposed to get a feedback from the upper layers?
>> 
>> Keep an eye on /proc/net/snmp
>
>It isn't very readable format..  Any other way or i have to
>read the code and see what the messages mean?

Quick and dirty script to neatly format /proc/net/snmp.  BTW, there is
a mismatch in the ICMP list on 2.4.17, 26 headers and 27 values :(.

cat > /tmp/$$a <<\****
while(<>) {
	chop;
	(@f) = split;
	if (++$line % 2) {
		@head = @f;
	}
	else {
		for ($i = 0; $i <= @f; ++$i) {
			printf "%-25s%s\n", $head[$i], $f[$i];
		}
	}
}
****
cat /proc/net/snmp | perl /tmp/$$a
rm /tmp/$$a

