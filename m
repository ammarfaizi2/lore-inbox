Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262854AbVAQTdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbVAQTdi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 14:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262852AbVAQTci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 14:32:38 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:12944 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S262851AbVAQTcM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 14:32:12 -0500
Date: Mon, 17 Jan 2005 14:32:06 -0500
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] shared subtrees
Message-ID: <20050117193206.GH24830@fieldses.org>
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk> <41EC0466.9010509@sun.com> <20050117190028.GF24830@fieldses.org> <41EC1253.8080902@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EC1253.8080902@sun.com>
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 02:30:27PM -0500, Mike Waychison wrote:
> Well, if I understand it correctly:
> 
> (assuming /foo is vfsmount A)
> 
> $> mount --make-shared /foo
> 
> will make A->A
> 
> $> mount --bind /foo /foo/bar
> 
> will create a vfsmount B based off A, but because A is in a p-node,
> A->B, B->A.
> 
> Then, we attach B to A in the vfsmount tree, but because A->B in the
> propagation tree, B also gets a vfsmount C added on dentry 'bar'.
> Recurse ad infinitum.
> 
> Make sense?

Yes, but couldn't the whole thing be avoided if we just agreed that the
propagation wasn't set up till after B was attached to A?

--b.
