Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261910AbVG0TjH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261910AbVG0TjH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 15:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVG0TgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 15:36:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:39841 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262145AbVG0Tet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 15:34:49 -0400
Date: Wed, 27 Jul 2005 15:34:32 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: serue@us.ibm.com
cc: lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>
Subject: Re: [patch 0/15] lsm stacking v0.3: intro
In-Reply-To: <20050727181732.GA22483@serge.austin.ibm.com>
Message-ID: <Lynx.SEL.4.62.0507271527390.1844@thoron.boston.redhat.com>
References: <20050727181732.GA22483@serge.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2005 serue@us.ibm.com wrote:

> if interested in the performance results.  I am certainly interested in
> ways to further speed up security_get_value.

What about having a small static array of security blob pointers for the 
common case (e.g. SELinux + capabilities + perhaps something else), the 
total number of which is compile-time configurable.  Reserve one pointer 
at the end for the hlist.

When a module registers with stacker, if there's room in the array, it 
reserves a slot for the module.  This slot value can be stored by stacker 
in a handle held by the module (along with the stacker ID etc. perhaps).

Calls to security_get_value() etc. can then be very fast and simple for 
the common case, where the security blob is a pointer offset by an index 
in a small array.  The arbitrarily sized hlist would then be a fallback 
with a higher performance hit.


- James
-- 
James Morris
<jmorris@redhat.com>

