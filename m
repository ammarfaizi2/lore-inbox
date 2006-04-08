Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751376AbWDHNou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbWDHNou (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 09:44:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWDHNou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 09:44:50 -0400
Received: from cantor2.suse.de ([195.135.220.15]:51369 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751376AbWDHNot (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 09:44:49 -0400
5A5ATo: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 1/5] uts namespaces: Implement utsname namespaces
References: <20060407095132.455784000@sergelap>
	<20060407183600.C8A8F19B8FD@sergelap.hallyn.com>
From: Andi Kleen <ak@suse.de>
Date: 08 Apr 2006 15:44:48 +0200
In-Reply-To: <20060407183600.C8A8F19B8FD@sergelap.hallyn.com>
Message-ID: <p73k6a09o6n.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Serge E. Hallyn" <serue@us.ibm.com> writes:

> This patch defines the uts namespace and some manipulators.
> Adds the uts namespace to task_struct, and initializes a
> system-wide init namespace which will continue to be used when
> it makes sense.

So to get this straight - you want to add a new pointer to 
task_struct for each possible virtualized entity? 

After you're doing by how many bytes will task_struct be bloated? 
I don't think that's a very good approach because you'll crank
up the per thread memory overhead which is already far too big
in Linux. Also it adds cache foot print and generally makes
things slower.

If anything I would request using a proxy data structure
that contains all the virtualized namespaces for a set
of processes. And give each task only has a single pointer
to one of these.

-Andi
