Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312235AbSDEHEy>; Fri, 5 Apr 2002 02:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312332AbSDEHEn>; Fri, 5 Apr 2002 02:04:43 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:41878 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S312235AbSDEHEf>; Fri, 5 Apr 2002 02:04:35 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Date: Fri, 5 Apr 2002 17:07:15 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15533.19747.471321.592478@notabene.cse.unsw.edu.au>
Subject: 2.5.7 Rules.make change break nfsd.
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



2.5.7 introduces:

-------------------------------------------------------------
#
# Rule to link composite objects
#

# for make >= 3.78 the following is cleaner:
# multi-used := $(foreach m,$(obj-y) $(obj-m), $(if $($(basename $(m))-Objs), $(m)))
multi-used := $(sort $(foreach m,$(obj-y) $(obj-m),$(patsubst %,$(m),$($(basename $(m))-objs))))
                                                                      ^^^^^^^^^^^^^^^^^^^^^^^
ld-multi-used := $(filter-out $(list-multi),$(multi-used))
ld-multi-objs := $(foreach m, $(ld-multi-used), $($(basename $(m))-objs))
------------------------------------------------------------


If the basename of some object is "export" (i.e. export.o), then the
underlined section referes to "export-objs" which is a macro that
already has a well defined meaning.

Maybe it should be "-Objs" or "-components" or ...

NeilBrown
