Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbVDMCgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbVDMCgp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 22:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbVDMCgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 22:36:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12520 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262310AbVDMCfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 22:35:07 -0400
Date: Wed, 13 Apr 2005 03:35:06 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] sound/oss/cs46xx.c: fix a check after use
Message-ID: <20050413023506.GQ8859@parcelfarce.linux.theplanet.co.uk>
References: <20050413021739.GS3631@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050413021739.GS3631@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2005 at 04:17:39AM +0200, Adrian Bunk wrote:
> This patch fixes a check after use found by the Coverity checker.

NAK.  Please, read the surrounding code.  All places that can call
that function have form
	<expression>->amplifier_ctrl(<same expression>,...);
so we _can't_ get NULL first argument.  The check should be removed -
it's not paranoia, it's simple stupidity.
