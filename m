Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129095AbQKDPIP>; Sat, 4 Nov 2000 10:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129186AbQKDPIF>; Sat, 4 Nov 2000 10:08:05 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:12307 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129095AbQKDPHw>; Sat, 4 Nov 2000 10:07:52 -0500
Date: Sat, 4 Nov 2000 16:07:35 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Elmer Joandi <elmer@ylenurme.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: OOPS: 2.4.0-test10-pre6 around reiserfs 3.6.18
Message-ID: <20001104160733.D2686@arthur.ubicom.tudelft.nl>
In-Reply-To: <Pine.LNX.4.10.10011040453160.10531-100000@yle-server.ylenurme.sise>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.10.10011040453160.10531-100000@yle-server.ylenurme.sise>; from elmer@ylenurme.ee on Sat, Nov 04, 2000 at 05:02:32AM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
X-Loop: erik@arthur.ubicom.tudelft.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 04, 2000 at 05:02:32AM +0200, Elmer Joandi wrote:
> under serious memory shortage, memory hog running and doing random access
> over 133 MB(128MB ram) and disk output as fast as it could.
> swap(128M) free = 0M, stable high disk io for long time, then
> me killing X with -9 , got oops.
     ^^^^^^^^^^^^^^^^^

Known problem. When you killed X, all shells wanted to update the
.bash_history (or .history) file at the same time, which triggered the
bug.

> /home is on reiserfs, which is on raid, which has 5 slices all on same
> disk (for fun).
> 
> 
> Nov  4 07:22:32 fw kernel:  printing eip: 
> Nov  4 07:22:32 fw kernel: c0133296 
> Nov  4 07:22:32 fw kernel: *pde = 00000000 
> Nov  4 07:22:32 fw kernel: Oops: 0000 
> Nov  4 07:22:32 fw kernel: CPU:    0 
> Nov  4 07:22:32 fw kernel: EIP:    0010:[block_read_full_page+14/500] 
                                           ^^^^^^^^^^^^^^^^^^^^
Yes, this looks like the symptom.

This was fixed in 2.4.0-test10-pre7, please upgrade to 2.4.0-test10
(final version) and see if it fixed your problem.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
