Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWHCGcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWHCGcn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 02:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWHCGcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 02:32:43 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60082 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932299AbWHCGcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 02:32:42 -0400
Date: Thu, 3 Aug 2006 02:32:30 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Pekka Enberg <penberg@cs.helsinki.fi>,
       linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
Message-ID: <20060803063230.GY32572@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20060611111815.8641.7879.stgit@localhost.localdomain> <20060611112156.8641.94787.stgit@localhost.localdomain> <84144f020606112219m445a3ccas7a95c7339ca5fa10@mail.gmail.com> <b0943d9e0606240320h1727639cv36a4fe399dddd767@mail.gmail.com> <20060624102248.GA23277@elte.hu> <20060724111554.GA5286@elte.hu> <b0943d9e0607240628n115deac4x3befe5d39037248f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0943d9e0607240628n115deac4x3befe5d39037248f@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2006 at 02:28:03PM +0100, Catalin Marinas wrote:
> On 24/07/06, Ingo Molnar <mingo@elte.hu> wrote:
> >update: there's also a neat gcc extension trick suggested by Arjan:
> >__builtin_classify_type(). This converts types into integers!
> 
> It's not really reliable as it doesn't distinguish well between types.
> All the structures, no matter what they contain, have the same id
> (which I think only refers to the fact that it is built-in type,
> pointer or structure, without differentiation).

__builtin_classify_type () doesn't give types unique ID, it only classifies
them:

/* Values returned by __builtin_classify_type.  */

enum type_class
{
  no_type_class = -1,
  void_type_class, integer_type_class, char_type_class,
  enumeral_type_class, boolean_type_class,
  pointer_type_class, reference_type_class, offset_type_class,
  real_type_class, complex_type_class,
  function_type_class, method_type_class,
  record_type_class, union_type_class,
  array_type_class, string_type_class,
  lang_type_class
};

All structures are given record_type_class, all unions union_type_class,
all pointers pointer_type_class, etc.
That doesn't mean you can't use it in the kernel as additional source
of type checking (in addition to e.g. sizeof and __alignof__).

	Jakub
