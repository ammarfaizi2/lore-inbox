Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752001AbWCIOmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbWCIOmM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 09:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751995AbWCIOmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 09:42:12 -0500
Received: from user-0c93tin.cable.mindspring.com ([24.145.246.87]:4828 "EHLO
	tsurukikun.utopios.org") by vger.kernel.org with ESMTP
	id S1752001AbWCIOmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 09:42:11 -0500
From: Luke-Jr <luke@dashjr.org>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: 9pfs double kfree
Date: Thu, 9 Mar 2006 14:48:11 +0000
User-Agent: KMail/1.9.1
Cc: "Dave Jones" <davej@redhat.com>, "Al Viro" <viro@ftp.linux.org.uk>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       ericvh@gmail.com, rminnich@lanl.gov
References: <20060306070456.GA16478@redhat.com> <20060306072823.GF21445@redhat.com> <84144f020603052356r321bc78dp66263fbfc73517c6@mail.gmail.com>
In-Reply-To: <84144f020603052356r321bc78dp66263fbfc73517c6@mail.gmail.com>
Public-GPG-Key: 0xD53E9583
Public-GPG-Key-URI: http://dashjr.org/~luke-jr/myself/Luke-Jr.pgp
IM-Address: luke-jr@jabber.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603091448.18585.luke@dashjr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 March 2006 07:56, Pekka Enberg wrote:
> On 3/6/06, Dave Jones <davej@redhat.com> wrote:
> > I wonder if we could get away with something as simple as..
> >
> > #define kfree(foo) \
> >         __kfree(foo); \
> >         foo = KFREE_POISON;
> >
> > ?
>
> It's legal to call kfree() twice for NULL pointer. The above poisons
> foo unconditionally which makes that case break I think.

#define kfree(foo) foo = __kfree(foo);

Assuming the current kfree doesn't return something...
