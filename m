Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130608AbRBUX1Q>; Wed, 21 Feb 2001 18:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130649AbRBUX1G>; Wed, 21 Feb 2001 18:27:06 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:275 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S130608AbRBUX04>;
	Wed, 21 Feb 2001 18:26:56 -0500
Date: Thu, 22 Feb 2001 00:26:48 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Martin Mares <mj@suse.cz>
Cc: "H. Peter Anvin" <hpa@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [rfc] Near-constant time directory index for Ext2
Message-ID: <20010222002648.A26568@pcep-jamie.cern.ch>
In-Reply-To: <20010221220835.A8781@atrey.karlin.mff.cuni.cz> <XFMail.20010221132959.davidel@xmailserver.org> <20010221223238.A17903@atrey.karlin.mff.cuni.cz> <971ejs$139$1@cesium.transmeta.com> <20010221233204.A26671@atrey.karlin.mff.cuni.cz> <3A94435D.59A4D729@transmeta.com> <20010221235008.A27924@atrey.karlin.mff.cuni.cz> <3A94470C.2E54EB58@transmeta.com> <20010222000755.A29061@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010222000755.A29061@atrey.karlin.mff.cuni.cz>; from mj@suse.cz on Thu, Feb 22, 2001 at 12:07:55AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Mares wrote:
> Hello!
> 
> > True.  Note too, though, that on a filesystem (which we are, after all,
> > talking about), if you assume a large linear space you have to create a
> > file, which means you need to multiply the cost of all random-access
> > operations with O(log n).
> 
> One could avoid this, but it would mean designing the whole filesystem in a
> completely different way -- merge all directories to a single gigantic
> hash table and use (directory ID,file name) as a key, but we were originally
> talking about extending ext2, so such massive changes are out of question
> and your log n access argument is right.

A gigantic hash table has serious problems with non-locality of
reference.  Basically any regular access pattern you started with is
destroyed.  This is a problem with pageable RAM, let alone disks with
millisecond seek times.

-- Jamie
