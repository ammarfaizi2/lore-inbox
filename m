Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWHVPL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWHVPL3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 11:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWHVPL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 11:11:29 -0400
Received: from gw.goop.org ([64.81.55.164]:33463 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932301AbWHVPL2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 11:11:28 -0400
Message-ID: <44EB1E9E.5030307@goop.org>
Date: Tue, 22 Aug 2006 08:11:26 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Ian Campbell <Ian.Campbell@xensource.com>
CC: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Ian Pratt <ian.pratt@xensource.com>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Chris Wright <chrisw@sous-sol.org>,
       Virtualization <virtualization@lists.osdl.org>,
       Christoph Lameter <clameter@sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 1 of 1] x86_64: Put .note.* sections into a PT_NOTE segment
 in vmlinux
References: <1156256777.5091.93.camel@localhost.localdomain>
In-Reply-To: <1156256777.5091.93.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Campbell wrote:
> It has been suggested to me that the notes segment should have flags 0
> (i.e. not readable) since it is only used by the loader and is not used
> at runtime. For now I went with a readable segment since that is what
> the i386 patch uses.
>   

Note that the PT_NOTEs segment is aliased to a part of one of the 
PT_LOADs - ie, it points into the data segment.  So making it -rwx would 
either be ignored, or also require putting the bits into a new PT_LOAD 
segment with 0 permissions, which is pretty pointless.  I made it R_E 
just so there was no permissions conflict, though the _E part could 
probably go.

    J
