Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbULPPE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbULPPE7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 10:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbULPPEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 10:04:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36510 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262675AbULPPB6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 10:01:58 -0500
Date: Thu, 16 Dec 2004 10:11:51 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Steve French <smfrench@austin.rr.com>
Cc: cliff white <cliffw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: cifs large write performance improvements to Samba
Message-ID: <20041216121151.GH8246@logos.cnet>
References: <41BDC9CD.60504@austin.rr.com> <20041213092057.5bf773fb.cliffw@osdl.org> <41BDE0B4.6020003@austin.rr.com> <41BDE2CF.9060402@austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41BDE2CF.9060402@austin.rr.com>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 12:43:27PM -0600, Steve French wrote:
> cliff white wrote:
> 
> >
> >>On Mon, 13 Dec 2004 10:56:45 -0600
> >>Steve French <smfrench@austin.rr.com> wrote:
> >>
> >>If only someone could roll all of the key fs tests into a set of 
> >>scripts which could generate one regularly updated set of test status 
> >>chart ... one for each of XFS, JFS, ext3, Reiser3, CIFS (against 
> >>various servers, Samba version etc), NFSv2, NFSv3, NFSv4 (against 
> >>various servers), AFS but that would be a lot of work (not to run) 
> >>but the first time writing/setup of the scripts to launch the tests 
> >>in the right order since some failures may be expected (at least for 
> >>the network filesystems) due to hard to implement features (missing 
> >>fcntls, dnotify, get/setlease, differences in byte range lock 
> >>semantics, lack of flock etc.) and also since the most sensible NFS, 
> >>AFS and CIFS tests would involve more than one client (to test 
> >>caching/oplock/token management semantics better) but no such fs 
> >>tests AFAIK exist for Linux.
> >>
> >>
> >>
> >>We ( OSDL ) would be very interested in this sort of testing. We have 
> >>some fs tests
> >>wrappered currently
> >>cliffw
> >>OSDL
> >>
> >>
> >
> The other thing I forgot to mention ... we used to have a concept of 
> "performance regression testing" (to make sure that we had not gotten a 
> lot slower on the latest rc) - not just runs on every release candidate 
> of a few complex benchmark tests (like SpecWeb or Netbench or some 
> enterprise Java perf test) but the idea was to run on every rc an fs 
> microbenchmark (more like iozone) to ensure that we did not have some 
> small functional problem in an fs or mm subsystem was causing big, 
> noticeable degradation in performance (large read or small read or large 
> write or small write, random or sequential etc.). I have not seen anyone 
> doing that on Linux in an automated fashion (e.g running iozone 
> automated every time a new 2.6.x.rc on a half a dozen of the fs - simply 
> to verify that things had not gotten drastically worse on a particular 
> fs due to a bug or sideffect of a global VFS change).

Yes, we definately need that.

The STP framework is running different benchmarks on each v2.6 new -mm and -mainline 
release already. Take a look at 

http://www.osdl.org/lab_activities/kernel_testing/stp/search.lnk/search_test_requests

There are two things considered important to me:

- Need to have a wide set of benchmarks to simulate a wide set of workloads. Having 
one microbenchmark limits the usefulness of the tests. This is very important.

- Need to parse the results of such tests in a way thats they are easily visualized

The second item of course depends on the number of variations that are ran. For
example you mention several filesystem, that would increase the amount of results
 dramatically.

We also need the manpower to carefully interpret the results (which is not trivial).

I would like to see different variations of memory size and CPU (1-2-4-8 CPU variation 
is already being done by STP), have been asking Cliff for such functionality for 
the past days.

One unfortunate thing is the failure rate for STP is currently really high. 
Cliff, the results I've received today and yesterday have a rough 50% failure rate.
Is anyone investigating that?

But Steve, to resume, the STP guys are working hard to make such 
IO/VM/FS performance tests automated and useful for the community. 

We need to push'em harder! :) 

