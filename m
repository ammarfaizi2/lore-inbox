Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315491AbSEZAsw>; Sat, 25 May 2002 20:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315503AbSEZAsv>; Sat, 25 May 2002 20:48:51 -0400
Received: from codepoet.org ([166.70.14.212]:51668 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S315491AbSEZAsv>;
	Sat, 25 May 2002 20:48:51 -0400
Date: Sat, 25 May 2002 18:48:53 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Robert Schwebel <robert@schwebel.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020526004853.GA18679@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Robert Schwebel <robert@schwebel.de>,
	Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0205250152110.15928-100000@hawkeye.luckynet.adm> <Pine.LNX.4.44.0205251015350.6515-100000@home.transmeta.com> <20020526005827.B598@schwebel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk5, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun May 26, 2002 at 12:58:27AM +0200, Robert Schwebel wrote:
> On Sat, May 25, 2002 at 10:22:00AM -0700, Linus Torvalds wrote:
> > So you split your problem into the RT device driver and the user. And of
> > story. 
> 
> Not possible with closed loop applications.  

Indeed.  For example -- suppose I have an application that is driving a
robot.  My application needs to calculate the target values for
each joint position in such that I can plot out the jerk,
acceleration, velocity, and position in cartesian space of a tool
moving in joint space (i.e. lots of 4x4 matrix multiplications,
often involving a full 3D model of the workcell) And I need to
send each new set of target values to the controller at the servo
rate or the robot will stutter.  

But if only it were that easy...  Since the target values we are
talking about is actually just the amount of current being sent
to the servo motors.  So also at the servo rate, I must read the
encoders for each joint to get its actual position (as opposed to
nominal postition) and feed that into a control routine
(typically using a PID routine using PID gains that vary
non-linearly per arm position, intertial loading, phase of the
moon, etc) which then varies the actual per-axis servo motor
current  to make the cartesian-space path of the tool match the
nominal path.

So now we have a full 3D model of the robot, the non-liner model
of the robot PID-gain space, the entire (application specific)
workcell model, the robot specific forward and inverse kinematics
routines, and the entire trajectory planning subsystem.  And of
course we now need the real-time IO subsystem to handle are the
thousands of this-and-that sensors (think PLC-type behavior).
etc, etc, etc.  All this in the kernel?  Nah...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
