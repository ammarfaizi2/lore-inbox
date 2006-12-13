Return-Path: <linux-kernel-owner+w=401wt.eu-S965073AbWLMS7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbWLMS7n (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 13:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbWLMS7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 13:59:43 -0500
Received: from mail1.key-systems.net ([81.3.43.211]:40555 "HELO
	mail1.key-systems.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965073AbWLMS7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 13:59:42 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 13:59:42 EST
Message-ID: <45804C0B.4030109@scientia.net>
Date: Wed, 13 Dec 2006 19:52:59 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.8 (X11/20061129)
MIME-Version: 1.0
To: Karsten Weiss <knweiss@gmx.de>
CC: linux-kernel@vger.kernel.org, ak@suse.de, andersen@codepoet.org,
       cw@f00f.org
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory
 hole mapping related bug?!
References: <4570CF26.8070800@scientia.net> <Pine.LNX.4.64.0612021048200.2981@addx.localnet>
In-Reply-To: <Pine.LNX.4.64.0612021048200.2981@addx.localnet>
Content-Type: multipart/mixed;
 boundary="------------080704000100040902010902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080704000100040902010902
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Karsten Weiss wrote:
> Here's a diff of a corrupted and a good file written during our
> testcase:
>
> ("-" == corrupted file, "+" == good file)
> ...
>   009f2ff0  67 2a 4c c4 6d 9d 34 44  ad e6 3c 45 05 9a 4d c4  |g*L.m.4D..<E..M.|
> -009f3000  39 60 e6 44 20 ab 46 44  56 aa 46 44 c2 35 e6 44  |9.D .FDV.FD.5.D|
> ....
> +009f3ff0  f3 55 92 44 c1 10 6c 45  5e 12 a0 c3 60 31 93 44  |.U.D..lE^...1.D|
>   009f4000  88 cd 6b 45 c1 6d cd c3  00 a5 8b 44 f2 ac 6b 45  |..kE.m.....D..kE|
>   
Well as I told in my mails to the list I made the experience that not
all bytes of the corrupted area are invalid,.. but only some,.. while it
seems that in you diff ALL the bytes are wrong, right?


> Please notice:
>
> a) the corruption begins at a page boundary
> b) the corrupted byte range is a single memory page and
> c) almost every fourth byte is set to 0x44 in the corrupted case
>     (but the other bytes changed, too)
>
> To me this looks as if a wrong memory page got written into the
> file.
>   
Hmm and do you have any ideas what's the reason for all this? Defect in
the nforce chipset? Or even in the CPU (the Opterons do have integrated
memory controllers).


> >From our testing I can also tell that the data corruption does
> *not* appear at all when we are booting the nodes with mem=2G.
> However, when we are using all the 4GB the data corruption
> shows up - but not everytime and thus not on all nodes.
> Sometimes a node runs for ours without any problem. That's why
> we are testing on 32 nodes in parallel most of the time. I have
> the impression that it has something to do with physical memory
> layout of the running processes.
>   
Hmm maybe,.. but I have absolutely no idea ;)


> Please also notice that this is a silent data corruption. I.e.
> there are no error or warning messages in the kernel log or the
> mce log at all.
>   
Yes I can confirm that.


> Christoph, I will carefully re-read your entire posting and the
> included links on Monday and will also try the memory hole
> setting.
>   
And did you get out anything new?

--------------080704000100040902010902
Content-Type: text/x-vcard; charset=utf-8;
 name="calestyo.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="calestyo.vcf"

YmVnaW46dmNhcmQNCmZuOk1pdHRlcmVyLCBDaHJpc3RvcGggQW50b24NCm46TWl0dGVyZXI7
Q2hyaXN0b3BoIEFudG9uDQplbWFpbDtpbnRlcm5ldDpjYWxlc3R5b0BzY2llbnRpYS5uZXQN
CngtbW96aWxsYS1odG1sOlRSVUUNCnZlcnNpb246Mi4xDQplbmQ6dmNhcmQNCg0K
--------------080704000100040902010902--
