Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281617AbRKPWqn>; Fri, 16 Nov 2001 17:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281635AbRKPWqd>; Fri, 16 Nov 2001 17:46:33 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:31249 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S281631AbRKPWqU>;
	Fri, 16 Nov 2001 17:46:20 -0500
Date: Fri, 16 Nov 2001 23:45:58 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Andre Hedrick <andre@linux-ide.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: death by ATA
Message-ID: <20011116234558.D11826@suse.de>
In-Reply-To: <3BF41608.DF8C7068@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BF41608.DF8C7068@zip.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15 2001, Andrew Morton wrote:
> What does "end-request: buffer-list destroyed" mean?

It means that the request was not sane anymore, or specifically that
clustered number of sectors was set to lower value than current number
of sectors (which isn't valid, of course). The buffer-list destroyed
comment tells you that this corruption is most likely due to the
buffer_head list on the request having been corrupted -- which in turn
probably means that someone seriously screwed this request.

hda8: bad access: block=5296, count=-2                            
end_request: I/O error, dev 03:08 (hda), sector 5296
hda8: bad access: block=5298, count=-4
end_request: I/O error, dev 03:08 (hda), sector 5298
hda8: bad access: block=5300, count=-6              
end_request: I/O error, dev 03:08 (hda), sector 5300

This errors would seem to backup that theory :-)

Is this an SMP board? Also, is

end_request: buffer-list destroyed

the very first error message?

-- 
Jens Axboe

