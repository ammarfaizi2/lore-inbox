Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265125AbUELQcs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265125AbUELQcs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 12:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265124AbUELQcs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 12:32:48 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:30094
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S265125AbUELQcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 12:32:47 -0400
Message-ID: <40A2517C.4040903@redhat.com>
Date: Wed, 12 May 2004 09:31:56 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a) Gecko/20040511
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Randy.Dunlap" <rddunlap@osdl.org>, fastboot@lists.osdl.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Re: [announce] kexec for linux 2.6.6
References: <20040511212625.28ac33ef.rddunlap@osdl.org>	<40A1AF53.3010407@redhat.com>	<m13c66qicb.fsf@ebiederm.dsl.xmission.com> <40A243C8.401@redhat.com> <m1brktod3f.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1brktod3f.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> As a first draft we should be able to use the standard ELF mechanisms
> for this.  It is not like PIC shared libraries were new.   Or is
> there some specific problem you are thinking of with respect to
> randomization?

The official kernel does not have vdso randomization.  Ingo has a patch
for the Red Hat kernel which is used in the FC2 kernel.  The patch
effectively only changes the location at which the vdso is mapped.  It
does not change the vdso content.  So the __kernel_vsyscall symbol in
the vdso's symbol table is not changed.

AT_SYSINFO is the right way to go forward but it is not directly
accessible to userlevel code.  And it is no pointer which will make
architectures with function descriptors unhappy.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
