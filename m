Return-Path: <linux-kernel-owner+w=401wt.eu-S965389AbXATVMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965389AbXATVMo (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 16:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965390AbXATVMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 16:12:44 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:28775 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965389AbXATVMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 16:12:44 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A5Jo7kwRycm03RDPIooYIEfocInxItnFkYdfuIBqd424Tp9OU8SwaKs0uX9NmbZOBu2mwqCHR+rYPpdrkxvk6sZuLgKbcd8FsGbysH+bGEJfpuF3QHSvBRLWwS4kVU7UZsLdsU0TKPZjbgQsy/eK9bvgAe0nTitZxFmtKn+9Ru4=
Message-ID: <8355959a0701201312r9a3aac4ufd151ca18ef7e64e@mail.gmail.com>
Date: Sun, 21 Jan 2007 02:42:42 +0530
From: "Sunil Naidu" <akula2.shark@gmail.com>
To: "Tim Schmielau" <tim@physik3.uni-rostock.de>
Subject: Re: Abysmal disk performance, how to debug?
Cc: "=?ISO-8859-1?Q?Ismail_D=F6nmez?=" <ismail@pardus.org.tr>,
       "Willy Tarreau" <w@1wt.eu>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0701202105210.23674@gockel.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200701201920.54620.ismail@pardus.org.tr>
	 <20070120174503.GZ24090@1wt.eu>
	 <200701201952.54714.ismail@pardus.org.tr>
	 <Pine.LNX.4.63.0701202105210.23674@gockel.physik3.uni-rostock.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/07, Tim Schmielau <tim@physik3.uni-rostock.de> wrote:
>
> Note that these dd "benchmarks" are completely bogus, because the data
> doesn't actually get written to disk in that time. For some enlightening
> data, try
>
>   time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024; time sync
>
> The dd returns as soon as all data could be buffered in RAM. Only sync
> will show how long it takes to actually write out the data to disk.
> also explains why you see better results is writeout starts earlier.

I am still getting better I feel:

[sukhoi@Typhoon ~]$ time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024; time sync
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB) copied, 19.5007 seconds, 55.1 MB/s

real    0m20.439s
user    0m0.004s
sys     0m4.535s

real    0m4.625s
user    0m0.000s
sys     0m0.125s


[sukhoi@Typhoon ~]$ time dd if=/dev/zero of=/tmp/1GB bs=1M count=1024 | sync
1024+0 records in
1024+0 records out
1073741824 bytes (1.1 GB) copied, 20.8707 seconds, 51.4 MB/s

real    0m22.449s
user    0m0.002s
sys     0m4.922s


Linux used here is not 2.6.20-rc5, but it's a FC6 2.6.19 binary. Shall
post the results with 2.6.20-rc5.

BTW, does the results vary with a customized kernel (configured w.r.t
Processor & Hardware) than a generic kernel like FC6?

Are there any other such test cases?

>
> Tim
>

Thanks,

~Akula2
