Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWIMI4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWIMI4a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 04:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbWIMI4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 04:56:30 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:54520 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751036AbWIMI43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 04:56:29 -0400
Subject: Re: [patch 1/9] Guest page hinting: unused / free pages.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Rik van Riel <riel@redhat.com>
Cc: Hubertus Franke <frankeh@watson.ibm.com>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au,
       rhim@cc.gateh.edu
In-Reply-To: <45075F09.5010708@redhat.com>
References: <20060901110908.GB15684@skybase> <45073901.8020906@redhat.com>
	 <45074BD0.3060400@watson.ibm.com>  <45075F09.5010708@redhat.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Wed, 13 Sep 2006 10:56:26 +0200
Message-Id: <1158137786.2560.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-12 at 21:29 -0400, Rik van Riel wrote:
> Note that the transition _to_ volatile can also be batched
> and done somewhat lazily.  For frequently mmaped pages that
> could end up saving us the transition the other way, too...

That would be helpful, only how to do it? We need some sort of list or
array where to store the pages that should be made volatile. The main
problem that I see is that you have to remove a page that is freed from
the list/array again, otherwise you would end up with a non page-cache
page being made volatile. That makes using per-cpu arrays hard since a
page can be freed on another cpu.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


