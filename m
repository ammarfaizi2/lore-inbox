Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261364AbREQBZZ>; Wed, 16 May 2001 21:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262164AbREQBZO>; Wed, 16 May 2001 21:25:14 -0400
Received: from [32.97.182.101] ([32.97.182.101]:31110 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261364AbREQBZJ>;
	Wed, 16 May 2001 21:25:09 -0400
Date: Wed, 16 May 2001 18:18:45 -0700
From: Mike Anderson <mike.anderson@us.ibm.com>
To: Andries.Brouwer@cwi.nl
Cc: rgooch@ras.ucalgary.ca, torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        geert@linux-m68k.org, hpa@transmeta.com,
        ingo.oeser@informatik.tu-chemnitz.de, jgarzik@mandrakesoft.com,
        linux-kernel@vger.kernel.org, neilb@cse.unsw.edu.au, viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
Message-ID: <20010516181845.A20663@us.ibm.com>
In-Reply-To: <UTC200105170018.CAA30316.aeb@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <UTC200105170018.CAA30316.aeb@vlet.cwi.nl>; from Andries.Brouwer@cwi.nl on Thu, May 17, 2001 at 02:18:20AM +0200
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl [Andries.Brouwer@cwi.nl] wrote:
> In principle the kernel could just number the devices it sees 1,2,...
> and export information about them, so that user space can choose
> the right number.
> The part about exporting information is good. User space needs to
> be able to ask if a certain beast is a CD reader, and if so what
> manufacturer and model.
> But the part about numbering 1,2,... may not be good enough, e.g.
> because it does not survive reboots. If we remain Unix-like and use
> device nodes in user space to pair a file name with a number, then
> it would be very nice if the number encoded the device path uniquely.
> Many programs expect this.
> It cannot be done in all cases, but a good approximation is obtained
> if the number is a hash of the device path. In so far the hash is
> collision free we obtain numbers that stay unique over a reboot.
> 
> Andries

I disagree that the kernel should apply sequence numbers as devices are
found or hash path information into the device name.

I am unclear of the need for the hashing the path into the name.

In the ptx operating system I previously worked on we ID'd everything
that we could get a UUID from and one's that we could not we generated a
pseudo one. We also split the UUID space up on config type. This is
similar to the discussion in Andreas's mail. Non-id'd devices could
possibly slip, but ID'd ones did not. In user space we allowed the user
to select any name for a device (the user space to kernel connection was
made by UUID. The solution worked on SCSI and FC based devices (Linux
obviously deals with many more device name spaces).

I thought with devfs, devreg, and non allocated major, minors. A
similar capability would be possible. The "/dev" usage would not need
to know the path, but methods would be available to make the
relationship when needed.

-Mike

-- 
Michael Anderson
mike.anderson@us.ibm.com

