Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278566AbRJSSDk>; Fri, 19 Oct 2001 14:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278568AbRJSSDa>; Fri, 19 Oct 2001 14:03:30 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:29068 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S278566AbRJSSDV>;
	Fri, 19 Oct 2001 14:03:21 -0400
Importance: Normal
Subject: Preliminary results of using multiblock raw I/O
To: lse-tech@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF3D1910E9.F8DA0202-ON85256AEA.0062AC09@pok.ibm.com>
From: "Shailabh Nagar" <nagar@us.ibm.com>
Date: Fri, 19 Oct 2001 14:03:46 -0400
X-MIMETrack: Serialize by Router on D01ML233/01/M/IBM(Release 5.0.8 |June 18, 2001) at
 10/19/2001 02:03:48 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Following up on the previous mail with patches for doing multiblock raw I/O
:

Experiments on a 2-way, 850MHz PIII, 256K cache, 256M memory
Running bonnie (modified to allow specification of O_DIRECT option,
target file etc.)
Only the block tests (rewrite,read,write) have been run. All tests
are single threaded.

BW  = bandwidth in kB/s
cpu = %CPU use
abs = size of each I/O request
      (NOT blocksize used by underlying raw I/O mechanism !)

pre2 = using kernel 2.4.13-pre2aa1
multi = 2.4.13-pre2aa1 kernel with multiblock raw I/O patches applied
        (both /dev/raw and O_DIRECT)

                  /dev/raw (uses 512 byte blocks)
               ===============================

         rewrite              write                   read
------------------------------------------------------------------
     pre2      multi       pre2     multi         pre2     multi
------------------------------------------------------------------
abs BW  cpu   BW  cpu     BW  cpu   BW  cpu      BW  cpu   BW  cpu
------------------------------------------------------------------
 4k 884 0.5   882 0.1    1609 0.3  1609 0.2     9841 1.5  9841 0.9
 6k 884 0.5   882 0.2    1609 0.5  1609 0.1     9841 1.8  9841 1.2
16k 884 0.6   882 0.2    1609 0.3  1609 0.0     9841 2.7  9841 1.4
18k 884 0.4   882 0.2    1609 0.4  1607 0.1     9841 2.4  9829 1.2
64k 883 0.5   882 0.1    1609 0.4  1609 0.3     9841 2.0  9841 0.6
66k 883 0.5   882 0.2    1609 0.5  1609 0.2     9829 3.4  9829 1.0


               O_DIRECT : on filesystem with 1K blocksize
            ===========================================

         rewrite              write                   read
------------------------------------------------------------------
     pre2      multi       pre2     multi         pre2     multi
------------------------------------------------------------------
abs BW  cpu   BW  cpu     BW  cpu   BW  cpu      BW  cpu   BW  cpu
------------------------------------------------------------------
 4k 854 0.8   880 0.4    1527 0.5  1607 0.1     9731 2.5  9780 1.3
 6k 856 0.4   882 0.3    1527 0.4  1607 0.1   9732 1.6  9780 0.7
16k 857 0.4   881 0.1     1527 0.3  1608 0.0  9732 2.2  9780 1.2
18k 857 0.3   882 0.2     1527 0.4  1607 0.1  9731 1.9  9780 1.0
64k 857 0.3   881 0.1     1526 0.4  1607 0.2  9732 1.6  9780 1.6
66k 856 0.4   882 0.2     1527 0.4  1607 0.2  9731 2.7  9780 1.2


Shailabh Nagar
Enterprise Linux Group, IBM TJ Watson Research Center
(914) 945 2851, T/L 862 2851

