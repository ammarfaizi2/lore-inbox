Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129673AbQKMNI7>; Mon, 13 Nov 2000 08:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129488AbQKMNIu>; Mon, 13 Nov 2000 08:08:50 -0500
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:37896 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S129481AbQKMNIk>; Mon, 13 Nov 2000 08:08:40 -0500
Date: Mon, 13 Nov 2000 14:06:41 +0100
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: aprasad@in.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: reliability of linux-vm subsystem
Message-ID: <20001113140641.A11229@arthur.ubicom.tudelft.nl>
In-Reply-To: <CA256996.004352F8.00@d73mta05.au.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <CA256996.004352F8.00@d73mta05.au.ibm.com>; from aprasad@in.ibm.com on Mon, Nov 13, 2000 at 05:29:48PM +0530
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
X-Loop: erik@arthur.ubicom.tudelft.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2000 at 05:29:48PM +0530, aprasad@in.ibm.com wrote:
> When i run following code many times.
> System becomes useless till all of the instance of this programming are
> killed by vmm.

Good, so the OOM killer works.

> Till that time linux doesn't accept any command though it switches from one
> VT to another but its useless.

VT swithing is done by the kernel itself, not by a process.

> The above programme is run as normal user previleges.
> Theoretically load should increase but system should services other users
> too.

No. The system would *like* to service other processes, but it *can't*
because it is trashing.

> but this is not behaving in that way.
> ___________________________________________________________________
> main()
> {
>      char *x[1000];
>      int count=1000,i=0;
>      for(i=0; i <count; i++)
>           x[i] = (char*)malloc(1024*1024*10); /*10MB each time*/
> 
> }
> _______________________________________________________________________
> If i run above programm for 10 times , then system is useless for around
> 5-7minutes on PIII/128MB.

Sounds quite normal to me. If you don't enforce process limits, you
allow a normal user to thrash the system.


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
