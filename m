Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWDSTuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWDSTuw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWDSTuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:50:52 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:25796 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751092AbWDSTuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:50:51 -0400
Date: Wed, 19 Apr 2006 21:50:24 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Arjan van de Ven <arjan@infradead.org>
cc: Crispin Cowan <crispin@novell.com>, Karl MacMillan <kmacmillan@tresys.com>,
       Gerrit Huizenga <gh@us.ibm.com>, Christoph Hellwig <hch@infradead.org>,
       James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
In-Reply-To: <1145472535.3085.94.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0604192143190.7177@yvahk01.tjqt.qr>
References: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com> 
 <1145381250.19997.23.camel@jackjack.columbia.tresys.com>  <44453E7B.1090009@novell.com>
  <1145389813.2976.47.camel@laptopd505.fenrus.org>  <44468258.1020608@novell.com>
 <1145472535.3085.94.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>> Note that d_path still returns pathnames for files that have been
>> removed from the filesystem (that are open)
>
>it does return "something". It just doesn't return meaningful pathnames.
>At all.
>
Exactly. It currently appends " (deleted)", which may even match an
existing file!

E.g.:
$ touch blah "blah (deleted)"
$ perl -e 'open I,blah;unlink blah;sleep 60' &
$ ls -l /proc/`echo $! `/fd/
lr-x------  1 jengelh root 64 Apr 19 21:48 3 -> /dev/shm/blah (deleted)

Note that ls will not colorize the part after ->, since that file actually
exists!


Jan Engelhardt
-- 
