Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263616AbUEGPPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263616AbUEGPPM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 11:15:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263653AbUEGPPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 11:15:12 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:25103 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263616AbUEGPPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 11:15:07 -0400
Date: Fri, 7 May 2004 16:14:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Morris <jmorris@redhat.com>
Cc: "David S. Miller" <davem@redhat.com>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH][SELINUX] 2/2 sock_create_lite()
Message-ID: <20040507161455.A31114@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Morris <jmorris@redhat.com>,
	"David S. Miller" <davem@redhat.com>,
	Stephen Smalley <sds@epoch.ncsc.mil>,
	Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com, selinux@tycho.nsa.gov
References: <Xine.LNX.4.44.0405071043540.21372@thoron.boston.redhat.com> <Xine.LNX.4.44.0405071056300.21372-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Xine.LNX.4.44.0405071056300.21372-100000@thoron.boston.redhat.com>; from jmorris@redhat.com on Fri, May 07, 2004 at 11:06:04AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 07, 2004 at 11:06:04AM -0400, James Morris wrote:
> This patch adds a function sock_create_lite(), deprecating kernel-wide use
> of sock_alloc(), which has been made static to net/socket.c.

We're in the stable series and removing exported APIs there shoudn't happen.
Given that sock_alloc() is actually okay for every normal use I don't think
there's enough reason to remove it from the API.

> +int sock_create_lite(int family, int type, int protocol, struct socket **res)

Should probably be called __sock_create according to linux naming rules.
Also I guess you should actually call it from sock_create instead of
duplicating the code.

