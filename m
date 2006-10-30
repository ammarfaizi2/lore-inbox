Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030551AbWJ3PwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030551AbWJ3PwX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 10:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030552AbWJ3PwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 10:52:23 -0500
Received: from smtp-out.google.com ([216.239.45.12]:56376 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030551AbWJ3PwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 10:52:22 -0500
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:user-agent:mime-version:to:cc:
	subject:references:in-reply-to:content-type:content-transfer-encoding;
	b=ocmBxr2Z2wabAm/J14aNjeTlCIsZZXUz8SviAHMXPAp2gNHYCDDWHgRQEw1fXQDD3
	BUL/9OZE5qTEAOTJAaZ+w==
Message-ID: <45461E74.1040408@google.com>
Date: Mon, 30 Oct 2006 07:47:00 -0800
From: "Martin J. Bligh" <mbligh@google.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Andy Whitcroft <apw@shadowen.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Steve Fox <drfickle@us.ibm.com>
Subject: Re: 2.6.19-rc3-mm1 -- missing network adaptors
References: <20061029160002.29bb2ea1.akpm@osdl.org> <45461977.3020201@shadowen.org>
In-Reply-To: <45461977.3020201@shadowen.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft wrote:
> Andrew Morton wrote:
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc3/2.6.19-rc3-mm1/
>>
>> - ia64 doesn't compile due to improvements in acpi.  I already fixed a huge
>>   string of build errors due to this and it's someone else's turn.
>>
>> - For some reason Greg has resurrected the patches which detect whether
>>   you're using old versions of udev and if so, punish you for it.
>>
>>   If weird stuff happens, try upgrading udev.
> 
> I have four machines showing problems with 2.6.19-rc3-mm1.  In each case
> they appear to have lost their ethernet cards completely.  I have a
> ppc64 using ibm_veth, two ppc64's using e1000's and an x86_64 using a
> Tigon 3.
> 
> Before I had results from the non e1000 machines I did try backing out
> all e1000 patches to no effect.  I also had a quick scan of the
> changelogs for net/ and nothing jumped out at me.
> 
> Any suggestions what to hack out next?

At least on one machine with 8 tg3 cards, it finds all its interfaces,
but then drops into:



Setting up network interfaces:
      lo
     lo        IP address: 127.0.0.1/8
7[?25l[1A[80C[10D[1;32mdone[m8[?25h    eth0
               No configuration found for eth0
7[?25l[1A[80C[10D[1munused[m8[?25h    eth1
             No configuration found for eth1

for all 8 cards.
(


Other ones just do this:


          .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  .  . 
  .  .  .7[?25l[80C[10D[1;32mdone[m8[?25h
[m[?25hSetting up network interfaces:
e1000: 0000:c8:01.0: e1000_probe: (PCI-X:133MHz:64-bit) 00:09:6b:6e:80:42
     lo
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
     lo        IP address: 127.0.0.1/8
7[?25l[1A[80C[10D[1;32mdone[m8[?25hWaiting for mandatory devices: 
eth-id-00:09:6b:6e:80:42
19 e1000: 0000:c8:01.1: e1000_probe: (PCI-X:133MHz:64-bit) 00:09:6b:6e:80:43
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
18 17 16 15 14 13 12 11 10 9 8 7 6 5 4 3 2 1 0
     eth-id-00:09:6b:6e:80:42            No interface found

(http://test.kernel.org/abat/59143/debug/console.log)

Sorry about the jibberish logs. Seems like SLES takes it upon itself
to spew random "enhanced" shit on bootup.

M.
