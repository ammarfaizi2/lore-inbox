Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270167AbRHGNb3>; Tue, 7 Aug 2001 09:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270210AbRHGNbT>; Tue, 7 Aug 2001 09:31:19 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:45284 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S270167AbRHGNbD>;
	Tue, 7 Aug 2001 09:31:03 -0400
Date: Tue, 7 Aug 2001 09:31:07 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Anton Altaparmakov <aia21@cam.ac.uk>,
        "Stephen C. Tweedie" <sct@redhat.com>, Chris Mason <mason@suse.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] using writepage to start io
In-Reply-To: <01080715292606.02365@starship>
Message-ID: <Pine.GSO.4.21.0108070928250.18565-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Aug 2001, Daniel Phillips wrote:

> One thread per block device; flushes across mounts on the same device
> are serialized.  This model works well for fs->device graphs that are
> strict trees.  For a non-strict tree (acyclic graph) its not clear
> what to do, but you could argue that such a configuration is stupid,
> so any kind of punt would do.

Except that you can have a part of fs structures on a separate device.
Journal, for one thing. Now think of two disks, both partitioned. Two
filesystems. Each has data on the first partition of its own disk.
And journal on the second of another.

