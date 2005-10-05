Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965204AbVJEO5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965204AbVJEO5K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 10:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965203AbVJEO5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 10:57:10 -0400
Received: from xproxy.gmail.com ([66.249.82.206]:4550 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965204AbVJEO5J convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 10:57:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=UgfvFBaRmAw4W7Mm7qr4ZdpHZfbykbrjqXySuNdWKToQizm8dHkgdsMygZao8tmrr8fB/FDzPulnCWC3w776fcDaRXpT+HtP4BpesWZkvfIORE9At0p9Yinmx8l9+tuQT/lEQOtrPW2KusNdIfT59bFgKAXHe7mkVS4L4CpIb8Q=
Message-ID: <b681c62b0510050757n2b3369flfba2d125912d8655@mail.gmail.com>
Date: Wed, 5 Oct 2005 20:27:08 +0530
From: yogeshwar sonawane <yogyas@gmail.com>
Reply-To: yogeshwar sonawane <yogyas@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: what is the difference between __free_page() & page_cache_release()
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
I am writing a driver for 2.6 in which i am locking down some pages
into the physical memory by manually traversing the page tables. After
my work with those pages is finished, i free them using 
__free_page(). For some cases it is running fine. But while running
some applications, i got the following error:

Bad page state at free_hot_cold_page (in process 'data_lat', page
0000010003d208e8)
flags:0x01000074 mapping:0000000000000000 mapcount:0 count:0
Backtrace:

Call Trace:<ffffffff801571f7>{bad_page+112}
<ffffffff801578cf>{free_hot_cold_page+130}
       <ffffffffa01aa101>{:ccp3k:VipkUnmapAndUnlock+162}
<ffffffffa01aaba0>{:ccp3k:VipkCloseNic+638}
       <ffffffffa01a812d>{:ccp3k:VipkClose+30} <ffffffff80173117>{__fput+99}
       <ffffffff80171d55>{filp_close+103}
<ffffffff80137771>{put_files_struct+101}
       <ffffffff80137f76>{do_exit+665} <ffffffff80138a2c>{sys_exit_group+0}
       <ffffffff8011003e>{system_call+126}
Trying to fix it up, but a reboot is needed

Then i replaced __free_page() with page_cache_release(). It is working
fine now. But what is the difference between these two? whether this
is the correct/safe replacement for __free_page()?
Can anybody help me out in this scenario? My machine is intel
xeon(EM64T) dual processor with redhat enterprise linux 4(2.6.9-11)
running on it.

if anybody knows any link about it, let me share that.

Thanks,
Yogeshwar
