Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267583AbUICEg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267583AbUICEg7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 00:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267732AbUICEg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 00:36:59 -0400
Received: from pointblue.com.pl ([81.219.144.6]:1548 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S267583AbUICEgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 00:36:55 -0400
Message-ID: <4137F4D9.7040206@pointblue.com.pl>
Date: Fri, 03 Sep 2004 06:36:41 +0200
From: =?UTF-8?B?R3J6ZWdvcnogSmHFm2tpZXdpY3o=?= <gj@pointblue.com.pl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
Cc: Rik van Riel <riel@redhat.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Matt Mackall <mpm@selenic.com>, Nicholas Miell <nmiell@gmail.com>,
       Wichert Akkerman <wichert@wiggy.net>, Jeremy Allison <jra@samba.org>,
       Andrew Morton <akpm@osdl.org>, Spam <spam@tnonline.net>,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <200408261034.38509.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.44.0408260736080.23532-100000@chimarrao.boston.redhat.com> <20040826121223.GG30449@mail.shareable.org>
In-Reply-To: <20040826121223.GG30449@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:

>Note that file-as-directory doesn't imply that you can store just
>anything into those directories.
>
>Is it a problem to decree that "file data MUST NOT be stored in a
>metadata directory; only non-essential metadata and data computed from
>the file data may be stored"?
>  
>

That's exactly what folks seem to lost in this debate.
We (developers) want to have files as dirs to:
* be able to extract/modify file part on fly. For instance, simple .iso 
file, without need to mount it over loop (btw, if someone is going to 
redesign VFS, can we handle that kinda case too please?), .tar, or 
unzipped (kernel can handle zips) "streams". File is a stream, why 
shouldn't I have a chance to grab a stream out of archive/image than ?
* be able to store metadata, that doesn't matter on copy, and even 
should not be copied sometimes. Things like thumbnails, metainformation 
(used for search). All of these extracted from acctual file (either by 
VFS 'plugins', or by userspace application), and saved there so that it 
can be used later on. So we save some time on extracting it.


--
GJ
