Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWHXIcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWHXIcL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 04:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWHXIcL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 04:32:11 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:9602 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750856AbWHXIcK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 04:32:10 -0400
Subject: Re: [PATCH 3/7] SLIM main patch
From: Arjan van de Ven <arjan@infradead.org>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: Benjamin LaHaise <bcrl@kvack.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       Dave Safford <safford@us.ibm.com>, Mimi Zohar <zohar@us.ibm.com>,
       Serge Hallyn <sergeh@us.ibm.com>
In-Reply-To: <1156371603.6720.101.camel@localhost.localdomain>
References: <1156359937.6720.66.camel@localhost.localdomain>
	 <20060823192733.GG28594@kvack.org>
	 <1156365357.6720.87.camel@localhost.localdomain>
	 <20060823204109.GI28594@kvack.org>
	 <1156371603.6720.101.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 24 Aug 2006 10:31:44 +0200
Message-Id: <1156408305.3014.38.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-23 at 15:20 -0700, Kylene Jo Hall wrote:
> On Wed, 2006-08-23 at 16:41 -0400, Benjamin LaHaise wrote:
> > On Wed, Aug 23, 2006 at 01:35:56PM -0700, Kylene Jo Hall wrote:
> > > Example: The current process is running at the USER level and writing to
> > > a USER file in /home/user/.  The process then attempts to read an
> > > UNTRUSTED file.  The current process will become UNTRUSTED and the read
> > > allowed to proceed but first write access to all USER files is revoked
> > > including the ones it has open.
> > 
> > Don't threads share file tables?  What is preventing malicious code from 
> > starting another thread which continues writing to the file that the 
> > revoke attempt is made on?
> 
> Well if they do share file tables then revoking write access from the
> file in the file table will revoke access for all threads.  It looks
> like sharing or copying the file table is based on a flag to the clone
> call and we are looking into whether you could exploit that situation.


well there's many corner cases; like dup2(), or sending the fd over unix
domains (and having it pending there while the revoke happens, and later
accept it)....


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com

