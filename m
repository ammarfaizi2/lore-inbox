Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932590AbWG1H1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbWG1H1F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 03:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932587AbWG1H1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 03:27:04 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:4280 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S932586AbWG1H1C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 03:27:02 -0400
Subject: Re: [3/4] kevent: AIO, aio_sendfile() implementation.
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Ulrich Drepper <drepper@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       netdev <netdev@vger.kernel.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>
In-Reply-To: <44C8DB80.6030007@us.ibm.com>
References: <1153905495613@2ka.mipt.ru> <11539054952574@2ka.mipt.ru>
	 <20060726100431.GA7518@infradead.org> <20060726101919.GB2715@2ka.mipt.ru>
	 <20060726103001.GA10139@infradead.org> <44C77C23.7000803@redhat.com>
	 <44C796C3.9030404@us.ibm.com> <1153982954.3887.9.camel@frecb000686>
	 <44C8DB80.6030007@us.ibm.com>
Date: Fri, 28 Jul 2006 09:26:50 +0200
Message-Id: <1154071610.13577.2.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 28/07/2006 09:31:40,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 28/07/2006 09:31:41,
	Serialize complete at 28/07/2006 09:31:41
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-27 at 08:28 -0700, Badari Pulavarty wrote:
> Sébastien Dugué wrote:
> > On Wed, 2006-07-26 at 09:22 -0700, Badari Pulavarty wrote:
> >   
> >> Ulrich Drepper wrote:
> >>     
> >>> Christoph Hellwig wrote:
> >>>   
> >>>       
> >>>>> My personal opinion on existing AIO is that it is not the right design.
> >>>>> Benjamin LaHaise agree with me (if I understood him right),
> >>>>>       
> >>>>>           
> >>>> I completely agree with that aswell.
> >>>>     
> >>>>         
> >>> I agree, too, but the current code is not the last of the line.  Suparna
> >>> has a st of patches which make the current kernel aio code work much
> >>> better and especially make it really usable to implement POSIX AIO.
> >>>
> >>> In Ottawa we were talking about submitting it and Suparna will.  We just
> >>> thought about a little longer timeframe.  I guess it could be
> >>> accelerated since he mostly has the patch done.  But I don't know her
> >>> schedule.
> >>>
> >>> Important here is, don't base any decision on the current aio
> >>> implementation.
> >>>   
> >>>       
> >> Ulrich,
> >>
> >> Suparna mentioned your interest in making POSIX glibc aio work with 
> >> kernel-aio at OLS.
> >> We thought taking a re-look at the (kernel side) work BULL did, would be 
> >> a nice starting
> >> point. I re-based those patches to 2.6.18-rc2 and sent it to Zach Brown 
> >> for review before
> >> sending them out to list.
> >>
> >> These patches does NOT make AIO any cleaner. All they do is add 
> >> functionality to support
> >> POSIX AIO easier. These are
> >>
> >> [ PATCH 1/3 ]  Adding signal notification for event completion
> >>
> >> [ PATCH 2/3 ]  lio (listio) completion semantics
> >>
> >> [ PATCH 3/3 ] cancel_fd support
> >>     
> >
> >   Badari,
> >
> >   Thanks for refreshing those patches, they have been sitting here
> > for quite some time now and collected dust.
> >
> >   I also think Suparna's patchset for doing buffered AIO would be
> > a real plus here.
> >
> >   
> >> Suparna explained these in the following article:
> >>
> >> http://lwn.net/Articles/148755/
> >>
> >> If you think, this is a reasonable direction/approach for the kernel and 
> >> you would take care
> >> of glibc side of things - I can spend time on these patches, getting 
> >> them to reasonable shape
> >> and push for inclusion.
> >>     
> >
> >   Ulrich, I you want to have a look at how those patches are put to
> > use in libposix-aio, have a look at http://sourceforge.net/projects/paiol.
> >
> >   It could be a starting point for glibc.
> >
> >   Thanks,
> >
> >   Sébastien.
> >
> >   
> Sebastien,
> 
> Suparna mentioned at Ulrich wants us to concentrate on kernel-side 
> support, so that he
> can look at glibc side of things (along with other work he is already 
> doing). So, if we
> can get an agreement on what kind of kernel support is needed - we can 
> focus our
> efforts on kernel side first and leave glibc enablement to capable hands 
> of Uli :)
> 

  That's fine with me. 

  Sébastien.

-- 
-----------------------------------------------------

  Sébastien Dugué                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
                   http://sourceforge.net/projects/paiol

-----------------------------------------------------

