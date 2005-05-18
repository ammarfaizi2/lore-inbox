Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262184AbVERLw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262184AbVERLw0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 07:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbVERLwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 07:52:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29120 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262180AbVERLwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 07:52:10 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <E1DYMVf-0000hD-00@dorka.pomaz.szeredi.hu> 
References: <E1DYMVf-0000hD-00@dorka.pomaz.szeredi.hu>  <E1DYMB6-0000dw-00@dorka.pomaz.szeredi.hu> <E1DYLvb-0000as-00@dorka.pomaz.szeredi.hu> <E1DYLCv-0000W7-00@dorka.pomaz.szeredi.hu> <1116005355.6248.372.camel@localhost> <E1DWf54-0004Z8-00@dorka.pomaz.szeredi.hu> <1116012287.6248.410.camel@localhost> <E1DWfqJ-0004eP-00@dorka.pomaz.szeredi.hu> <1116013840.6248.429.camel@localhost> <E1DWprs-0005D1-00@dorka.pomaz.szeredi.hu> <1116256279.4154.41.camel@localhost> <20050516111408.GA21145@mail.shareable.org> <1116301843.4154.88.camel@localhost> <E1DXm08-0006XD-00@dorka.pomaz.szeredi.hu> <20050517012854.GC32226@mail.shareable.org> <E1DXuiu-0007Mj-00@dorka.pomaz.szeredi.hu> <1116360352.24560.85.camel@localhost> <E1DYI0m-0000K5-00@dorka.pomaz.szeredi.hu> <1116399887.24560.116.camel@localhost> <1116400118.24560.119.camel@localhost> <6865.1116412354@redhat.com> <7230.1116413175@redhat.com> <8247.1116413990@redhat.com> 
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linuxram@us.ibm.com, jamie@shareable.org,
       viro@parcelfarce.linux.theplanet.co.uk, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fix race in mark_mounts_for_expiry() 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 22.0.50.1
Date: Wed, 18 May 2005 12:51:39 +0100
Message-ID: <9498.1116417099@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Miklos Szeredi <miklos@szeredi.hu> wrote:

> Do you think my original fix is wrong, or is this just cosmetics?

What you're doing is tricky. It's asking for a race. Admittedly, it may not
occur in the particular situation you're looking at, but can you always
guarantee that? Remember, it may be a race against some piece of code that's
not yet written, by an author who doesn't realise what _you_ are doing here
because their changeset doesn't intersect with yours.

Remember: you have, in effect, made the usage count on that structure
non-atomic.

I do something like that in rwsems and it's something I have to be very
careful about. The main reason I can get away with it is that the actual
implementation of rwsems is small and is located in a very restrictes set of
places and it's not intermingled with other stuff.

David
