Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288960AbSAIS66>; Wed, 9 Jan 2002 13:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288966AbSAIS6t>; Wed, 9 Jan 2002 13:58:49 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:58774
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288960AbSAIS6m>; Wed, 9 Jan 2002 13:58:42 -0500
Message-Id: <200201091843.g09IhnA25130@snark.thyrsus.com>
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Two hdds on one channel - why so slow?
Date: Wed, 9 Jan 2002 05:56:32 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <200201041740.LAA07840@tomcat.admin.navo.hpc.mil> <200201082029.g08KTAA28497@snark.thyrsus.com> <20020108161819.A1878@node0.opengeometry.ca>
In-Reply-To: <20020108161819.A1878@node0.opengeometry.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 January 2002 04:18 pm, William Park wrote:
> On Tue, Jan 08, 2002 at 07:41:42AM -0500, Rob Landley wrote:
> > The goal was to see how cheaply we could get to 10 terabytes of storage. 
> > We didn't do the whole cluster, but I think we determined we only needed
> > 4 or 5 nodes to do it.  Then the dot-com crash hit and that company's
> > business model changed, project got shelved...
>
> Hi Rob, how did you manage to get 10TB storage?  It's my understanding
> that kernel block device still counts 1kB blocks using 32bit (signed)
> integer.  So, that's 2TB in total.  Are you talking about 5 x 2TB?

Made a cluster.

We were extracting stuff out of it via URL, with a database to lookup where 
each URL lived, so we could have different files live on different servers.  
(If we'd wanted everything to look like it lived on exactly the same machine, 
we could have had one machine mount the other machines' space via samba or 
nfs, but that would have created extra network traffic inside the cluster.)

The proposed design was to have the whole cluster look like it was at 1 
public IP address via IP masquerading and port forwarding (port 80 is the 
apache on node 0, 81 is the apache on node 1, 82 is the apache on node 2...)  
This was just to save world-routable IPs.  We didn't get that far...

Bascially, we just wanted lots of storage, cheap and reliable (we were doing 
RAID 5 across the disks in each cluster), and didn't care what it looked 
like.  We were also experimenting with DVD jukeboxes to feed data into the 
cluster (the cluster was cache for larger offline storage, the project was to 
license syndicated television content (old episodes of mash, battlestar 
galactica, you name it) and provide video on demand for a flat monthly fee.  
Each local cable company would have a cluster, which would pull data through 
the internet from servers in atlanta or california, wherever an ultimate 
content licensor lived.  It could be shipped around on DVD stacks too...)

Fun project.  Too bad it didn't work out...

Rob
