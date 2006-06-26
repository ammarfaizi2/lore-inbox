Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932969AbWFZThN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932969AbWFZThN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 15:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932973AbWFZThN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 15:37:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33674 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932969AbWFZThK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 15:37:10 -0400
Date: Mon, 26 Jun 2006 15:37:04 -0400
From: Dave Jones <davej@redhat.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-390@vm.marist.edu
Subject: Re: [PATCH] s390: fix duplicate export of overflow{ug}id
Message-ID: <20060626193704.GF18599@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Serge E. Hallyn" <serue@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	linux-390@vm.marist.edu
References: <20060626193141.GB32035@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626193141.GB32035@sergelap.austin.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 02:31:41PM -0500, Serge E. Hallyn wrote:
 > overflowuid and overflowgid were exported twice.  Remove the export
 > from s390_ksyms.c

There's a gotcha with this.  in kernel/sys.c, we only export those
symbols if CONFIG_UID16 is set.  iirc, there was some part of
arch/s390 that expected to use those symbols even if it wasn't set.

Does everything still link with that option both set and unset ?

		Dave

-- 
http://www.codemonkey.org.uk
