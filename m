Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263116AbVAFX2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263116AbVAFX2n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 18:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263061AbVAFXZZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 18:25:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:33965 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263110AbVAFXV5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 18:21:57 -0500
Date: Thu, 6 Jan 2005 15:26:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: paulmck@us.ibm.com, arjan@infradead.org, linux-kernel@vger.kernel.org,
       jtk@us.ibm.com, wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-Id: <20050106152621.395f935e.akpm@osdl.org>
In-Reply-To: <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk>
References: <20050106190538.GB1618@us.ibm.com>
	<1105039259.4468.9.camel@laptopd505.fenrus.org>
	<20050106201531.GJ1292@us.ibm.com>
	<20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk>
	<20050106210408.GM1292@us.ibm.com>
	<20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Guys, the technical arguments are all of course correct.  But the fact
remains that we broke things without any notice.  (Yes, perhaps someone did
say something at sometime, but the affected party didn't know, and it's our
job to make sure that they knew).  (These exports were removed in October -
the IBM guys need to work out why it took so long to detect the breakage).

I think the exports should be restored.  So does Linus ("Not that I like it
all that much, but I don't think we should break existing modules unless we
have a very specific reason to break just those modules.").

Which begs the question "how do we ever get rid of these things when we
have no projected date for Linux-2.8"?

I'd propose:

a) Create Documentation/feature-removal-schedule.txt which describes
   things which are going away, when, why, who is involved, etc.

b) Mark things deprecated where appropriate.

c) For module exports it would be nice if we could get the module loader
   to print a message "module foo.o uses deprecated symbol files_lock". 
   Dunno how hard that would be.

   Alternatively perhaps we could arrange for the symbol to be marked
   deprecated if it's used from a module:

   #ifdef MODULE
   #define deprecated_if_module __deprecated
   #else
   #define deprecated_if_module
   #endif

   Just something to really draw people's attention to the fact that
   their code will break at a well-defined date.


