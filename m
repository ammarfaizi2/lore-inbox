Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263687AbUDMTKL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 15:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263688AbUDMTKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 15:10:11 -0400
Received: from outmx002.isp.belgacom.be ([195.238.3.52]:50623 "EHLO
	outmx002.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S263687AbUDMTKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 15:10:06 -0400
Subject: Re: [PATCH 2.6.5-mm4] sys_access race fix
From: Fabian Frederick <Fabian.Frederick@skynet.be>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040413115052.O22989@build.pdx.osdl.net>
References: <1081881778.5585.16.camel@bluerhyme.real3>
	 <20040413115052.O22989@build.pdx.osdl.net>
Content-Type: text/plain
Message-Id: <1081883544.5585.30.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 13 Apr 2004 21:12:27 +0200
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx002.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-13 at 20:50, Chris Wright wrote:
> * Fabian Frederick (Fabian.Frederick@skynet.be) wrote:
> > Andrew,
> > 
> > 	I'm trying to remove the race in sys_access code.
> > AFAICS, fsuid is checked in "permission" level so I pushed real
fsuid
> > capture forward.At that state, I can task_lock (which was impossible
> > before user_walk).Could you tell me if I can improve this one ?
> 
> This changes the semantics of the directory checks implicit
> during the pathname resolution.

Well, the only major function behind user_walk is path_lookup.
This one has some calls with the nameidata.Other process seems
current->fs->xxx relevant read-only.Maybe you mean the
read_lock(&current->fs->lock) which could bring a deadlock as we
task->lock before ? 

If user_walk had to run in ruid, why would we have permission() then ?

Regards,
Fabian

> thanks,
> -chris

