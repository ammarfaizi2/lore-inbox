Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262720AbVDYSeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbVDYSeu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 14:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262722AbVDYSeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 14:34:50 -0400
Received: from [80.71.243.242] ([80.71.243.242]:11752 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S262720AbVDYSer (ORCPT
	<rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Mon, 25 Apr 2005 14:34:47 -0400
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17005.14407.228930.83593@gargle.gargle.HOWL>
Date: Mon, 25 Apr 2005 22:34:47 +0400
To: David Teigland <teigland@redhat.com>
Cc: akpm@osdl.org, Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: Re: [PATCH 1b/7] dlm: core locking
Newsgroups: gmane.linux.kernel
In-Reply-To: <20050425165826.GB11938@redhat.com>
References: <20050425165826.GB11938@redhat.com>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Teigland writes:
 > 
 > The core dlm functions.  Processes dlm_lock() and dlm_unlock() requests.

[...]

 > +
 > +static int is_remote(struct dlm_rsb *r)
 > +{
 > +	DLM_ASSERT(r->res_nodeid >= 0, dlm_print_rsb(r););
 > +	return r->res_nodeid ? TRUE : FALSE;
 > +}

This can be simply

        return r->res_nodeid;

 > +
 > +static int is_master(struct dlm_rsb *r)
 > +{
 > +	return r->res_nodeid ? FALSE : TRUE;
 > +}

This duplicates dlm_is_master() for no obvious reason.

 > +
 > +int dlm_is_master(struct dlm_rsb *r)
 > +{
 > +	return r->res_nodeid ? FALSE : TRUE;
 > +}

This can be simply

        return !r->res_nodeid;

Nikita.
