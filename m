Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751765AbWF1XNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbWF1XNf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 19:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751766AbWF1XNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 19:13:35 -0400
Received: from father.pmc-sierra.com ([216.241.224.13]:62719 "HELO
	father.pmc-sierra.bc.ca") by vger.kernel.org with SMTP
	id S1751765AbWF1XNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 19:13:34 -0400
Subject: Re: IS_ERR Threshold Value
From: Erik Frederiksen <erik_frederiksen@pmc-sierra.com>
To: Nathan Scott <nathans@sgi.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060629084128.C1344246@wobbly.melbourne.sgi.com>
References: <20060629084128.C1344246@wobbly.melbourne.sgi.com>
Content-Type: text/plain
Organization: PMC-Sierra
Message-Id: <1151536413.3903.1135.camel@girvin.pmc-sierra.bc.ca>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-17) 
Date: Wed, 28 Jun 2006 17:13:33 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On Wed, 2006-06-28 at 16:41, Nathan Scott wrote:
> 
> Hmm, I'm not sure I understand the XFS side of your report here - on
> open, for quota to be coming into play we must be creating a new inode
> and those code paths inside XFS have no use of IS_ERR/ERR_PTR magic...
> did you mean there's generic problems here (I can see those macros are
> used in the generic VFS open() code) ... or am I missing your point?

Yes, that's right.  The error is being returned from xfs_create when
quota has been exceeded.  It ends up carrying back to the filp_open call
in do_sys_open, which returns it as a pointer to a filp structure. 
Because the errno is so large, IS_ERR reports it as being a valid
pointer incorrectly.

XFS has acted correctly.  The only reason I bring it up is this is how
the bug was brought to my attention.  

If there won't be any strange side effects (I don't have the experience
to accurately comment on this), I think turning the threshold value up
to something we can get away with in IS_ERR_VALUE() would be
appropriate.

-erik

