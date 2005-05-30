Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVE3Ump@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVE3Ump (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 16:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261742AbVE3Ump
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 16:42:45 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:19929 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261740AbVE3Umg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 16:42:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=qdtVD/JxzNBXS/QilVpAiFznFQl5Tp30qU7w1xe8aCwleGODEQuOHsB68LYFFJNw/SBllWui2PUP/YrHmjEVIX3HzmTU5172tMljwGmNfUIsDmBvVDWiG8nHyr2PcqEPKM9Ali7zGUIcypEnN3IgNorYad0QOzlp6jH+y06Sfe4=
Message-ID: <429B7AB5.5080400@gmail.com>
Date: Mon, 30 May 2005 22:42:29 +0200
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050523)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86-64: Use SSE for copy_page and clear_page
References: <20050530181626.GA10212@kvack.org> <20050530193823.GD25794@muc.de> <429B7208.6070804@gmail.com> <20050530201419.GB10212@kvack.org>
In-Reply-To: <20050530201419.GB10212@kvack.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise schrieb:

>On Mon, May 30, 2005 at 10:05:28PM +0200, Michael Thonke wrote:
>  
>
>>No it doesn't like this sample here at all,I'll get segmentationfault on
>>that run.
>>    
>>
>
>Grab a new copy -- one of the routines had an unaligned store instead of 
>aligned for the register save.
>
>		-ben
>
>  
>
Hi Benjamin,

Here are the results with the new copy.

    *RUN 1: cc -o xmm64.o xmm64.c*

    ioGL64NX_EMT64 ~ # ./xmm64.o
    SSE test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $
    buffer = 0x2aaaaade7000
    clear_page() tests
    clear_page function 'warm up run'        took 13632 cycles per page
    clear_page function 'kernel clear'       took 6599 cycles per page
    clear_page function '2.4 non MMX'        took 6482 cycles per page
    clear_page function '2.4 MMX fallback'   took 6367 cycles per page
    clear_page function '2.4 MMX version'    took 6644 cycles per page
    clear_page function 'faster_clear_page'  took 6088 cycles per page
    clear_page function 'even_faster_clear'  took 5692 cycles per page
    clear_page function 'xmm_clear'  took 4270 cycles per page
    clear_page function 'xmma_clear'         took 6351 cycles per page
    clear_page function 'xmm2_clear'         took 4710 cycles per page
    clear_page function 'xmma2_clear'        took 6198 cycles per page
    clear_page function 'xmm3_clear'         took 6583 cycles per page
    clear_page function 'nt clear  '         took 4746 cycles per page
    clear_page function 'kernel clear'       took 6158 cycles per page

    copy_page() tests
    copy_page function 'warm up run'         took 9210 cycles per page
    copy_page function '2.4 non MMX'         took 6740 cycles per page
    copy_page function '2.4 MMX fallback'    took 6697 cycles per page
    copy_page function '2.4 MMX version'     took 9178 cycles per page
    copy_page function 'faster_copy'         took 11360 cycles per page
    copy_page function 'even_faster'         took 10133 cycles per page
    copy_page function 'xmm_copy_page_no'    took 8885 cycles per page
    copy_page function 'xmm_copy_page'       took 8725 cycles per page
    copy_page function 'xmma_copy_page'      took 9964 cycles per page
    copy_page function 'xmm3_copy_page'      took 7176 cycles per page
    copy_page function 'v26_copy_page'       took 6879 cycles per page
    copy_page function 'nt_copy_page'        took 10858 cycles per page


    *RUN 2: gcc -o xmm64.o xmm64.c*

    ioGL64NX_EMT64 ~ # ./xmm64.o
    SSE test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $
    buffer = 0x2aaaaade7000
    clear_page() tests
    clear_page function 'warm up run'        took 13981 cycles per page
    clear_page function 'kernel clear'       took 6708 cycles per page
    clear_page function '2.4 non MMX'        took 6505 cycles per page
    clear_page function '2.4 MMX fallback'   took 6235 cycles per page
    clear_page function '2.4 MMX version'    took 7251 cycles per page
    clear_page function 'faster_clear_page'  took 6390 cycles per page
    clear_page function 'even_faster_clear'  took 5932 cycles per page
    clear_page function 'xmm_clear'  took 4876 cycles per page
    clear_page function 'xmma_clear'         took 6379 cycles per page
    clear_page function 'xmm2_clear'         took 5264 cycles per page
    clear_page function 'xmma2_clear'        took 6373 cycles per page
    clear_page function 'xmm3_clear'         took 6651 cycles per page
    clear_page function 'nt clear  '         took 5186 cycles per page
    clear_page function 'kernel clear'       took 6326 cycles per page

    copy_page() tests
    copy_page function 'warm up run'         took 9537 cycles per page
    copy_page function '2.4 non MMX'         took 6776 cycles per page
    copy_page function '2.4 MMX fallback'    took 7407 cycles per page
    copy_page function '2.4 MMX version'     took 8812 cycles per page
    copy_page function 'faster_copy'         took 10992 cycles per page
    copy_page function 'even_faster'         took 10232 cycles per page
    copy_page function 'xmm_copy_page_no'    took 8918 cycles per page
    copy_page function 'xmm_copy_page'       took 9579 cycles per page
    copy_page function 'xmma_copy_page'      took 9854 cycles per page
    copy_page function 'xmm3_copy_page'      took 7602 cycles per page
    copy_page function 'v26_copy_page'       took 6811 cycles per page
    copy_page function 'nt_copy_page'        took 10958 cycles per page

    *RUN 3: gcc -pipe -march=nocona -O2 -o xmm64.o xmm64.c
    *
    SSE test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $
    buffer = 0x2aaaaade7000
    clear_page() tests
    clear_page function 'warm up run'        took 13626 cycles per page
    clear_page function 'kernel clear'       took 6780 cycles per page
    clear_page function '2.4 non MMX'        took 6755 cycles per page
    clear_page function '2.4 MMX fallback'   took 6283 cycles per page
    clear_page function '2.4 MMX version'    took 6764 cycles per page
    clear_page function 'faster_clear_page'  took 5764 cycles per page
    clear_page function 'even_faster_clear'  took 5240 cycles per page
    clear_page function 'xmm_clear'  took 4532 cycles per page
    clear_page function 'xmma_clear'         took 6352 cycles per page
    clear_page function 'xmm2_clear'         took 4983 cycles per page
    clear_page function 'xmma2_clear'        took 6211 cycles per page
    clear_page function 'xmm3_clear'         took 6748 cycles per page
    clear_page function 'nt clear  '         took 5166 cycles per page
    clear_page function 'kernel clear'       took 6201 cycles per page

    copy_page() tests
    copy_page function 'warm up run'         took 9651 cycles per page
    copy_page function '2.4 non MMX'         took 6724 cycles per page
    copy_page function '2.4 MMX fallback'    took 6905 cycles per page
    copy_page function '2.4 MMX version'     took 9722 cycles per page
    copy_page function 'faster_copy'         took 9738 cycles per page
    copy_page function 'even_faster'         took 9609 cycles per page
    copy_page function 'xmm_copy_page_no'    took 8846 cycles per page
    copy_page function 'xmm_copy_page'       took 8591 cycles per page
    copy_page function 'xmma_copy_page'      took 8250 cycles per page
    copy_page function 'xmm3_copy_page'      took 7879 cycles per page
    copy_page function 'v26_copy_page'       took 7512 cycles per page
    copy_page function 'nt_copy_page'        took 10424 cycles per page

    RUN 4: *gcc -pipe -march=nocona -O2 -fPIC -o xmm64.o xmm64.c*

    SSE test program $Id: fast.c,v 1.6 2000/09/23 09:05:45 arjan Exp $
    buffer = 0x2aaaaade7000
    clear_page() tests
    clear_page function 'warm up run'        took 13713 cycles per page
    clear_page function 'kernel clear'       took 6655 cycles per page
    clear_page function '2.4 non MMX'        took 6448 cycles per page
    clear_page function '2.4 MMX fallback'   took 6270 cycles per page
    clear_page function '2.4 MMX version'    took 7001 cycles per page
    clear_page function 'faster_clear_page'  took 5671 cycles per page
    clear_page function 'even_faster_clear'  took 5366 cycles per page
    clear_page function 'xmm_clear'  took 4737 cycles per page
    clear_page function 'xmma_clear'         took 6464 cycles per page
    clear_page function 'xmm2_clear'         took 5214 cycles per page
    clear_page function 'xmma2_clear'        took 6371 cycles per page
    clear_page function 'xmm3_clear'         took 6660 cycles per page
    clear_page function 'nt clear  '         took 5066 cycles per page
    clear_page function 'kernel clear'       took 6314 cycles per page

    copy_page() tests
    copy_page function 'warm up run'         took 9464 cycles per page
    copy_page function '2.4 non MMX'         took 7179 cycles per page
    copy_page function '2.4 MMX fallback'    took 6928 cycles per page
    copy_page function '2.4 MMX version'     took 9091 cycles per page
    copy_page function 'faster_copy'         took 9996 cycles per page
    copy_page function 'even_faster'         took 9824 cycles per page
    copy_page function 'xmm_copy_page_no'    took 8724 cycles per page
    copy_page function 'xmm_copy_page'       took 8920 cycles per page
    copy_page function 'xmma_copy_page'      took 8859 cycles per page
    copy_page function 'xmm3_copy_page'      took 7794 cycles per page
    copy_page function 'v26_copy_page'       took 7808 cycles per page
    copy_page function 'nt_copy_page'        took 9264 cycles per page

    Do you need more results or tests Benjamin?

    Greets and best regards
        Michael

