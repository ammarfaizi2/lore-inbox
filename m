Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264542AbUFLChj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUFLChj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 22:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264543AbUFLChj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 22:37:39 -0400
Received: from lakermmtao05.cox.net ([68.230.240.34]:30933 "EHLO
	lakermmtao05.cox.net") by vger.kernel.org with ESMTP
	id S264542AbUFLChh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 22:37:37 -0400
Mime-Version: 1.0 (Apple Message framework v618)
Content-Transfer-Encoding: 7bit
Message-Id: <772741DF-BC19-11D8-888F-000393ACC76E@mac.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: In-kernel Authentication Tokens (PAGs)
Date: Fri, 11 Jun 2004 22:37:36 -0400
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am working on a generic PAG subsystem for the kernel, something that
handles BLOB PAG data and could be used for OpenAFS, Coda, NFSv4, etc.
I have a patch, but it is not well tested yet.  Here is an overview of 
the
architecture:

Each process has a PAG, and each PAG has a parent PAG.  Users are
allowed to make new PAGs associated with their UID and modify ones that
are already associated with their UID.  Each PAG consists of a set of 
tokens,
each uniquely identified by an integral "type" and a string "realm."  
The
search for a token by any subsystem is done starting at the immediate 
parent
and proceeds upward.  Tokens are in kernel memory and so are not ever
swapped out.

Each PAG is represented in user-space as an integer.  Here are the 
sys-calls
that I propose:

sys_get_pag
sys_set_pag
	These manipulate the PAG associated with a given PID.

sys_get_pag_parent
sys_set_pag_parent
	These manipulate the parent PAG of a given PAG

sys_get_pag_uid
sys_set_pag_uid
	These manipulate the UID which "owns" a PAG

sys_get_pag_token
sys_set_pag_token
	These manipulate tokens within a specific PAG

sys_search_pag_token
	This executes the search process as described above

Cheers,
Kyle Moffett

