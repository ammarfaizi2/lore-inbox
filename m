Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbVHYLME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbVHYLME (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 07:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbVHYLME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 07:12:04 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:61522 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S964939AbVHYLMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 07:12:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=RXtuIQ7vJAg1/pTXMo6P9P6vXr3tlnzjvRAHcuhphSjYt8UwnXZR5Vlz+THDdZkrd8joKtvvr1u4kWmpZrXd53g2HjgGESOiUgwiOFf7WWeM8M0gwXFvvaPQDVhpGrBb7EkByl1L+meFNmeVJvGoMBv8gyrwPxO+JoxUoYub/8g=  ;
Subject: Re: [PATCH] removes filp_count_lock and changes nr_files type to
	atomic_t
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <430DA052.9070908@cosmosbay.com>
References: <20050824214610.GA3675@localhost.localdomain>
	 <1124956563.3222.8.camel@laptopd505.fenrus.org>
	 <430D8518.8020502@cosmosbay.com> <20050825090854.GA9740@infradead.org>
	 <430D8CA3.3030709@cosmosbay.com> <20050825092322.GA9902@infradead.org>
	 <430DA052.9070908@cosmosbay.com>
Content-Type: text/plain
Date: Thu, 25 Aug 2005 21:11:49 +1000
Message-Id: <1124968309.5856.9.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-25 at 12:41 +0200, Eric Dumazet wrote:

> OK, here is a new clean patch that address this problem (nothing assumed about 
> atomics)
> 

Would you just be able to add the atomic sysctl handler that
Christoph suggested?

This introduces lost update problems. 2 CPUs may store to nr_files
in the opposite order that they incremented atomic_nr_files.

It is not terribly bad, because the drift is not cumulative and the
field can't go negative... but its just ugly to add this hack
because there is no atomic sysctl handler.

Eliminating the cli/sti is a good idea though, I think.

-- 
SUSE Labs, Novell Inc.



Send instant messages to your online friends http://au.messenger.yahoo.com 
