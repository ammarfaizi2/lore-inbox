Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264455AbUAaAqo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 19:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264451AbUAaAqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 19:46:44 -0500
Received: from ns.suse.de ([195.135.220.2]:23442 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264455AbUAaAqO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 19:46:14 -0500
To: Mark Haverkamp <markh@osdl.org>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl, linux-kernel@vger.kernel.org
Subject: Re: ide taskfile and cdrom hang
References: <1075502193.26342.61.camel@markh1.pdx.osdl.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 31 Jan 2004 01:46:13 +0100
In-Reply-To: <1075502193.26342.61.camel@markh1.pdx.osdl.net.suse.lists.linux.kernel>
Message-ID: <p73ekthlzca.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Haverkamp <markh@osdl.org> writes:

> We have some test machines here at OSDL that have a problem with the ide
> cdrom driver hanging when we cat the /proc/ide/hda/identify file. After
> 30 seconds the console displays: "hda: lost interrupt" which reoccurs
> every 30 seconds forever. We noticed it on 2.6.2-rc2-mm1 but It looks
> like this has been a problem for a while. Our test machines just changed
> their configuration to use make defconfig.  I found that if
> CONFIG_IDE_TASKFILE_IO is N then the hang doesn't occur.  Is this a
> common problem or are there just certain drives that won't work with
> taskfile i/o enabled?  I've included my .config, lspci as attachments.  
> The cdrom model is CD-224E.

I looked at this some time ago together with BenH and Bart. The problem 
seems to be that the taskfile statemachine for identify is quite broken.
(even when it didn't hang it usually returned only garbage on other
CD ROMs). 

The CD ROM doesn't answer the request for some reason and then the
Linux taskfile code goes into an endless loop sending retries.

Bart had a patch to at least cure the hang by erroring out.

-Andi

