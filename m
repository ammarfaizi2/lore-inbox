Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751426AbVJRUDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbVJRUDi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 16:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbVJRUDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 16:03:38 -0400
Received: from mail.s.netic.de ([212.9.160.11]:55559 "EHLO mail.s.netic.de")
	by vger.kernel.org with ESMTP id S1751426AbVJRUDi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 16:03:38 -0400
From: Guido Fiala <gfiala@s.netic.de>
To: linux-kernel@vger.kernel.org
Subject: large files unnecessary trashing filesystem cache?
Date: Tue, 18 Oct 2005 22:01:10 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510182201.11241.gfiala@s.netic.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(please note, i'am not subscribed to the list, please CC me on reply)

Story:
Once in while we have a discussion at the vdr (video disk recorder) mailing 
list about very large files trashing the filesystems memory cache leading to 
unnecessary delays accessing directory contents no longer cached.

This program and certainly all applications that deal with very large files 
only read once (much larger than usual memory)  - it happens that all other 
cached blocks of the filessystem are removed from memory solely to keep as 
much as possible of that file in memory, which seems to be a bad strategy in 
most situations.

Of course one could always implement f_advise-calls in all applications, but i 
suggest a discussion if a maximum (configurable) in-memory-cache on a 
per-file base should be implemented in linux/mm or where this belongs.

My guess was, it has something to do with mm/readahead.c, a test limiting the 
result of the function "max_sane_readahead(...) to 8 MBytes as a quick and 
dirty test did not solve the issue, but i might have done something wrong.

I've searched the archive but could not find a previous discussion - is this a 
new idea?

It would be interesting to discuss if and when this proposed feature could 
lead to better performance or has any unwanted side effects.

Thanks for ideas on that issue.
