Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261799AbTAaSbF>; Fri, 31 Jan 2003 13:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261836AbTAaSbF>; Fri, 31 Jan 2003 13:31:05 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:34516 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261799AbTAaSbE>; Fri, 31 Jan 2003 13:31:04 -0500
Date: Fri, 31 Jan 2003 13:39:29 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: kai@tp1.ruhr-uni-bochum.de
Cc: linux-kernel@vger.kernel.org
Subject: Perl in the toolchain
Message-ID: <20030131133929.A8992@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai, what's your opinion? I suspect you missed my posing to l-k
http://www.uwsg.indiana.edu/hypermail/linux/kernel/0301.3/1203.html

-- Pete

Date: Thu, 30 Jan 2003 14:53:59 +0100
From: Konrad Eisele <eiselekd@web.de>
To: "PeteZaitcev" <zaitcev@redhat.com>
Subject: Adding sparc-leon linux to sourcetree

.....
There is also one change I have made on the buildsystem. Because I'm using some 
perl inline scripts in the $cmd_xxx the >'<  and >$< signs in the inline perl scripts 
cause trouble (perl -e '...$x=....'), the >'< because of the echo command, the >$< when
rereading from the xxx..cmd files. Could this be applied to the original file?

scripts/Makefile.lib:
+-------------------------------+

# ===========================================================================
# Generic stuff
# ===========================================================================

# function to only execute the passed command if necessary
# the ' -> '\'' and $ to $$ substitution are done if $(cmd_$(1)) includes a inline perlscript

if_changed = $(if $(strip $? \
		          $(filter-out $(cmd_$(1)),$(cmd_$@))\
			  $(filter-out $(cmd_$@),$(cmd_$(1)))),\
	@set -e; \
	$(if $($(quiet)cmd_$(1)),echo '  $(subst ','\'',$($(quiet)cmd_$(1)))';) \
	$(cmd_$(1)); \
	echo 'cmd_$@ := $(subst $$,$$$$,$(subst ','\'',$(cmd_$(1))))' > $(@D)/.$(@F).cmd)

----- End forwarded message -----
