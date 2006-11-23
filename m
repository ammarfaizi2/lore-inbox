Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754256AbWKWLcq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754256AbWKWLcq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 06:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755432AbWKWLcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 06:32:46 -0500
Received: from mail.parknet.jp ([210.171.160.80]:22536 "EHLO parknet.jp")
	by vger.kernel.org with ESMTP id S1754256AbWKWLco (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 06:32:44 -0500
X-AuthUser: hirofumi@parknet.jp
To: The Peach <smartart@tiscali.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug? VFAT copy problem
References: <20061120164209.04417252@localhost>
	<877ixqhvlw.fsf@duaron.myhome.or.jp>
	<20061120184912.5e1b1cac@localhost>
	<87mz6kajks.fsf@duaron.myhome.or.jp>
	<20061122163001.0d291978@localhost>
	<8764d7v4nh.fsf@duaron.myhome.or.jp>
	<20061122201008.17072c89@localhost>
	<87r6vvs2k4.fsf@duaron.myhome.or.jp>
	<20061122203859.017d5723@localhost>
	<87zmaj1cpv.fsf@duaron.myhome.or.jp>
	<20061122232124.09695d57@localhost>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Thu, 23 Nov 2006 20:32:38 +0900
In-Reply-To: <20061122232124.09695d57@localhost> (The Peach's message of "Wed\, 22 Nov 2006 23\:21\:24 +0100")
Message-ID: <87lkm21jqh.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Peach <smartart@tiscali.it> writes:

> anyway I didn't get why some files will copy with the right case and
> other don't. Was it a problem with the dentry table randomly failing
> in saving the filename?

If it's shortname (the detail of shortname is following), the
"shortname=" option solves a problem. If it's longname (not
shortname), the patch solves a problem. The your case seems to need both.

 * 1) Valid characters for the 8.3 format alias are any combination of
 * letters, uppercase alphabets, digits, any of the
 * following special characters:
 *     $ % ' ` - @ { } ~ ! # ( ) & _ ^
 * In this case Longfilename is not stored in disk.
 *
 * WinNT's Extension:
 * File name and extension name is contain uppercase/lowercase
 * only. And it is expressed by CASE_LOWER_BASE and CASE_LOWER_EXT.
 *
 * 2) File name is 8.3 format, but it contain the uppercase and
 * lowercase char, muliti bytes char, etc. In this case numtail is not
 * added, but Longfilename is stored.
 *
 * 3) When the one except for the above, or the following special
 * character are contained:
 *        .   [ ] ; , + =
 * numtail is added, and Longfilename must be stored in disk .
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
