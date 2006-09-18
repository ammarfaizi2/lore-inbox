Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965641AbWIRKbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965641AbWIRKbg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 06:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965643AbWIRKbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 06:31:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63382 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965641AbWIRKbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 06:31:35 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060918033431.GV3034@melbourne.sgi.com> 
References: <20060918033431.GV3034@melbourne.sgi.com>  <patchbomb.1158455366@turing.ams.sunysb.edu> <4cdee5980dad9980ec8f.1158455371@turing.ams.sunysb.edu> 
To: David Chinner <dgc@sgi.com>
Cc: "Josef 'Jeff' Sipek" <jeffpc@josefsipek.net>, linux-kernel@vger.kernel.org,
       xfs-masters@oss.sgi.com, akpm@osdl.org, dhowells@redhat.com
Subject: Re: [PATCH 5 of 11] XFS: Use SEEK_{SET, CUR, END} instead of hardcoded values 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Mon, 18 Sep 2006 11:30:35 +0100
Message-ID: <2442.1158575435@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Chinner <dgc@sgi.com> wrote:

> The hard coded values  used in xfs_change_file_space() are documented as part
> of the API to the userspace functions that use this interface in xfsctl(3).

Hmmm... that's a good point.  I think you're right on this account, and so the
comments in:

		case 0: /*SEEK_SET*/
			break;
		case 1: /*SEEK_CUR*/
			bf->l_start += offset;
			break;
		case 2: /*SEEK_END*/
			bf->l_start += ip->i_d.di_size;
			break;

should be stripped off as they are not exactly correct.

David
