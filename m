Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265147AbUD3LeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265147AbUD3LeN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 07:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbUD3LeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 07:34:13 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:45580 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S265147AbUD3LeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 07:34:09 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: arjanv@redhat.com
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Date: Fri, 30 Apr 2004 14:33:30 +0300
User-Agent: KMail/1.5.4
Cc: Tim Connors <tconnors+linuxkernel1083305837@astro.swin.edu.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       brettspamacct@fastclick.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <40904A84.2030307@yahoo.com.au> <18781898240.20040430121833@port.imtp.ilyichevsk.odessa.ua> <1083317615.4633.7.camel@laptop.fenrus.com>
In-Reply-To: <1083317615.4633.7.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404301433.31187.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 April 2004 12:33, Arjan van de Ven wrote:
> > Multimedia content (jpegs etc) is typically cached in
> > filesystem, so Mozilla polluted pagecache with it when
> > it saved JPEGs to the cache *and* then it keeps 'em in RAM
> > too, which doubles RAM usage.
>
> well if mozilla just mmap's the jpegs there is no double caching .....

I may be wrong but Mozilla keeps unpacked bitmap in malloc() space.
The point is, $BloatyApp will keep bloating up while you
are working upon improving kernel. I guess it's very clear which
process is easier. You cannot win that race.

This is OpenOffice on idle 128Mb RAM, 1000MHz Duron machine with KDE,
Mozilla and KMail running:

# time swriter;time swriter

real    0m33.906s
user    0m10.163s
sys     0m0.705s

real    0m24.025s
user    0m10.069s
sys     0m0.546s

I closed windows as soon as it appeared.

Freshly started swriter in top:
  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU COMMAND
 2081 root      15   0 93980  41M 80300 S     1,3 34,0   0:09   0 soffice.bin

93 megs. 10 seconds of 1GHz CPU time taken...
--
vda

