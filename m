Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261365AbSJCUZn>; Thu, 3 Oct 2002 16:25:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261369AbSJCUZn>; Thu, 3 Oct 2002 16:25:43 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:39696 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S261365AbSJCUZm>;
	Thu, 3 Oct 2002 16:25:42 -0400
Date: Thu, 3 Oct 2002 22:30:54 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
       kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RfC: Don't cd into subdirs during kbuild
Message-ID: <20021003223054.A31484@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai-germaschewski@uiowa.edu>,
	kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210022153090.10307-100000@chaos.physics.uiowa.edu> <20021003220120.B17403@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021003220120.B17403@mars.ravnborg.org>; from sam@ravnborg.org on Thu, Oct 03, 2002 at 10:01:20PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 10:01:20PM +0200, Sam Ravnborg wrote:
> Now it's testing time..

1)
In order to make it link I had to change the following in rules.make:
 # If the list of objects to link is empty, just create an empty O_TARGET
 cmd_link_o_target = $(if $(strip $(obj-y)),\
-                     $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) -r -o $@ $(filter $(obj-y), $^),\
+                     $(LD) $(LDFLAGS) $(EXTRA_LDFLAGS) -r -o $@ $(filter-out FORCE,$(obj-y)),\
                      rm -f $@; $(AR) rcs $@)

Otherwise no objects were on the commandline because make strips ./

2)
Top-level Makefile still uses make -C therefore apths are relative to first
subdirectory as seen here:
  CC      udf/balloc.o
  CC      udf/dir.o
  CC      udf/file.o
  CC      udf/ialloc.o
  

3) acpi failed to compile due to  -Idrivers/acpi/include, but current
directory is drivers.

	Sam
