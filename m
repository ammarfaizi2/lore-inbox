Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316512AbSHXPJT>; Sat, 24 Aug 2002 11:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316519AbSHXPJT>; Sat, 24 Aug 2002 11:09:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48141 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316512AbSHXPJS>;
	Sat, 24 Aug 2002 11:09:18 -0400
Date: Sat, 24 Aug 2002 16:13:29 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk
Cc: mec@shout.net
Subject: Of hanging menuconfig [cause found]
Message-ID: <20020824151329.GB735@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.4.18 (i686)
X-Uptime: 15:58:39 up 19:50,  1 user,  load average: 2.05, 2.02, 2.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  make menuconfig   will hang just after the parsing in the
activate_menu loop in the case where the file scripts/lxdialog/lxdialog
won't execute.  Some error codes in this case are caught; but the case
where the file scripts/lxdialog/lxdialog is a binary for the wrong
architecture (case 126) is not caught.  This is quite easy to trip if
you are swapping between native and cross building - you get a couple of
errors when you try and build make menuconfig for the first time about
wrong binaries; in my case I just deleted those binaries and did the
make again; however this failure is silent - it just hangs.

A make mrproper   is probably the best thing to do when switching - but
the error case needs catching, and I'm sure there are other similar
cases.

Dave

P.S. This was on 2.4.18-rmk7 but I believe it is general.
P.P.S. Is it a good idea to keep binaries in the scripts subdirectory?

 ---------------- Have a happy GNU millennium! ----------------------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM, SPARC and HP-PA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
