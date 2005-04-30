Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVD3Ih6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVD3Ih6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 04:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVD3Ih6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 04:37:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20142 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261159AbVD3Ihr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 04:37:47 -0400
Date: Sat, 30 Apr 2005 09:37:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Olivier Galibert <galibert@pobox.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050430083742.GD23253@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Olivier Galibert <galibert@pobox.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <E1DPoRz-0000Y0-00@localhost> <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <20050425094804.GA33040@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425094804.GA33040@dspnet.fr.eu.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2005 at 11:48:04AM +0200, Olivier Galibert wrote:
> On Sun, Apr 24, 2005 at 10:19:42PM +0100, Al Viro wrote:
> > Of course you can.  It does execute the obvious set of rc files.
> 
> Is there a possibility for a process to change its namespace to
> another existing one?  That would be needed to have a per-user
> namespace you go to from rc files or pam.

It is not right now, and I don't think joining a namespace is a concept
that fits very well into our architecture.  What does make sense is an
unshare() syscall that takes the CLONE_* argument and unshares those in
the current process from the parent without creating a new process.  Then
you can easily reproduce another namespace by value instead of by reference.

