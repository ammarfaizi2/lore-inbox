Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268126AbUHQHAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268126AbUHQHAa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 03:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268127AbUHQHA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 03:00:29 -0400
Received: from holomorphy.com ([207.189.100.168]:11693 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268126AbUHQHAT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 03:00:19 -0400
Date: Tue, 17 Aug 2004 00:00:11 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Nathan Lynch <nathanl@austin.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm1
Message-ID: <20040817070011.GM11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Nathan Lynch <nathanl@austin.ibm.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040816143710.1cd0bd2c.akpm@osdl.org> <121120000.1092699569@flay> <1092706344.3081.4.camel@booger> <20040817065901.GB7173@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040817065901.GB7173@mars.ravnborg.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2004 at 08:32:24PM -0500, Nathan Lynch wrote:
>> I hit the same thing on ppc64 with gcc 3.3.2-ish.  Doing a non-parallel
>> make (i.e. without -j) seems to work around it for me.

On Tue, Aug 17, 2004 at 08:59:01AM +0200, Sam Ravnborg wrote:
> Fix below:

The result of this appears to be:

$ time make -s -j16 rpm
Building target platforms: x86_64
Building for target x86_64
Executing(%prep): /bin/sh -e /mnt/rpmbuild/tmp/rpm-tmp.55854
+ umask 022
+ cd /mnt/rpmbuild/BUILD
+ cd /mnt/rpmbuild/BUILD
+ rm -rf kernel-2.6.8.1mm1
+ /usr/bin/gzip -dc /home/wli/kernel-2.6.8.1mm1.tar.gz
+ tar -xf -
+ STATUS=0
+ '[' 0 -ne 0 ']'
+ cd kernel-2.6.8.1mm1
++ /usr/bin/id -u
+ '[' 1000 = 0 ']'
++ /usr/bin/id -u
+ '[' 1000 = 0 ']'
+ /bin/chmod -Rf a+rX,g-w,o-w .
+ exit 0
Executing(%build): /bin/sh -e /mnt/rpmbuild/tmp/rpm-tmp.95241
+ umask 022
+ cd /mnt/rpmbuild/BUILD
+ /bin/rm -rf /var/tmp/kernel-2.6.8.1mm1-root
++ dirname /var/tmp/kernel-2.6.8.1mm1-root
+ /bin/mkdir -p /var/tmp
+ /bin/mkdir /var/tmp/kernel-2.6.8.1mm1-root
+ cd kernel-2.6.8.1mm1
+ make clean
make[2]: warning: jobserver unavailable: using -j1.  Add `+' to parent make rule.
+ make -j16
make[2]: warning: -jN forced in submake: disabling jobserver mode.
  CHK     include/linux/version.h
  UPD     include/linux/version.h
  SYMLINK include/asm -> include/asm-x86_64
  SPLIT   include/linux/autoconf.h -> include/config/*
cc1: error: output filename specified twice
make[2]: *** [scripts/kallsyms] Error 1
make[2]: *** Waiting for unfinished jobs....
error: Bad exit status from /mnt/rpmbuild/tmp/rpm-tmp.95241 (%build)


RPM build errors:
    Bad exit status from /mnt/rpmbuild/tmp/rpm-tmp.95241 (%build)
make[1]: *** [rpm] Error 1
make: *** [rpm] Error 2
make -s -j16 rpm  38.38s user 9.50s system 81% cpu 58.513 total


-- wli
