Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbVKAIpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbVKAIpp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbVKAIpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:45:45 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:2445 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S964972AbVKAIpo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:45:44 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: /etc/mtab and per-process namespaces
Date: Tue, 1 Nov 2005 02:44:49 -0600
User-Agent: KMail/1.8
Cc: linuxram@us.ibm.com, greg@enjellic.com, mikew@google.com,
       linux-kernel@vger.kernel.org, leimy2k@gmail.com
References: <200510221323.j9MDNimA009898@wind.enjellic.com> <200510311727.27145.rob@landley.net> <E1EWqgc-0006AY-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1EWqgc-0006AY-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511010244.49532.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 November 2005 01:36, Miklos Szeredi wrote:
> > (Then, of course, there's FUSE.  Does killing the FUSE helper
> > prevent the mount from being umounted?)
>
> No.  On clean exit (via INT, TERM, HUP handlers installed by library)
> it will lazy umount itself.  Violent death of a filesystem daemon will
> leave the mount intact, but umountable.

Ok, so it sounds like the proper init-go-byebye procedure once namespaces get 
deployed is for init to kill all child processes, umount -a what's left in 
its namespace, and all is well.  So no changes are needed to the umount -a 
implementation...

Rob
