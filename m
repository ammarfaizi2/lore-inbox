Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278053AbRJVHqV>; Mon, 22 Oct 2001 03:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278057AbRJVHqL>; Mon, 22 Oct 2001 03:46:11 -0400
Received: from mail.scs.ch ([212.254.229.5]:6370 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id <S278053AbRJVHqC>;
	Mon, 22 Oct 2001 03:46:02 -0400
Message-ID: <3BD3CFB8.6E5CE530@scs.ch>
Date: Mon, 22 Oct 2001 09:50:16 +0200
From: Reto Baettig <baettig@scs.ch>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Shailabh Nagar <nagar@us.ibm.com>
CC: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Preliminary results of using multiblock raw I/O
In-Reply-To: <OF3D1910E9.F8DA0202-ON85256AEA.0062AC09@pok.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

We had 200MB/s on 2.2.18 with the SGI raw patch and CPU-Load
approximately 10%.
On 2.4.3-12, we get 100MB/s with 100% CPU-Load. Is there a way of
getting even bigger transfers than one page for the aligned part? With
the SGI patch, there was much less waiting for I/O completion  because
we could transfer 1MB in one chunk. I'm sorry but I don't have time at
the moment to test the patch but I will send you our numbers as soon as
we have some time.

Good to see somebody working on it! Thanks!

Reto

Shailabh Nagar wrote:
> 
> Following up on the previous mail with patches for doing multiblock raw I/O
> :
> 
> Experiments on a 2-way, 850MHz PIII, 256K cache, 256M memory
> Running bonnie (modified to allow specification of O_DIRECT option,
> target file etc.)
> Only the block tests (rewrite,read,write) have been run. All tests
> are single threaded.
> 
> BW  = bandwidth in kB/s
> cpu = %CPU use
> abs = size of each I/O request
>       (NOT blocksize used by underlying raw I/O mechanism !)
> 
> pre2 = using kernel 2.4.13-pre2aa1
> multi = 2.4.13-pre2aa1 kernel with multiblock raw I/O patches applied
>         (both /dev/raw and O_DIRECT)
> 
>                   /dev/raw (uses 512 byte blocks)
>                ===============================
> 
>          rewrite              write                   read
> ------------------------------------------------------------------
>      pre2      multi       pre2     multi         pre2     multi
> ------------------------------------------------------------------
> abs BW  cpu   BW  cpu     BW  cpu   BW  cpu      BW  cpu   BW  cpu
> ------------------------------------------------------------------
>  4k 884 0.5   882 0.1    1609 0.3  1609 0.2     9841 1.5  9841 0.9
>  6k 884 0.5   882 0.2    1609 0.5  1609 0.1     9841 1.8  9841 1.2
> 16k 884 0.6   882 0.2    1609 0.3  1609 0.0     9841 2.7  9841 1.4
> 18k 884 0.4   882 0.2    1609 0.4  1607 0.1     9841 2.4  9829 1.2
> 64k 883 0.5   882 0.1    1609 0.4  1609 0.3     9841 2.0  9841 0.6
> 66k 883 0.5   882 0.2    1609 0.5  1609 0.2     9829 3.4  9829 1.0
> 
>                O_DIRECT : on filesystem with 1K blocksize
>             ===========================================
> 
>          rewrite              write                   read
> ------------------------------------------------------------------
>      pre2      multi       pre2     multi         pre2     multi
> ------------------------------------------------------------------
> abs BW  cpu   BW  cpu     BW  cpu   BW  cpu      BW  cpu   BW  cpu
> ------------------------------------------------------------------
>  4k 854 0.8   880 0.4    1527 0.5  1607 0.1     9731 2.5  9780 1.3
>  6k 856 0.4   882 0.3    1527 0.4  1607 0.1   9732 1.6  9780 0.7
> 16k 857 0.4   881 0.1     1527 0.3  1608 0.0  9732 2.2  9780 1.2
> 18k 857 0.3   882 0.2     1527 0.4  1607 0.1  9731 1.9  9780 1.0
> 64k 857 0.3   881 0.1     1526 0.4  1607 0.2  9732 1.6  9780 1.6
> 66k 856 0.4   882 0.2     1527 0.4  1607 0.2  9731 2.7  9780 1.2
> 
> Shailabh Nagar
> Enterprise Linux Group, IBM TJ Watson Research Center
> (914) 945 2851, T/L 862 2851
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
