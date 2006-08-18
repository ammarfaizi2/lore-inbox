Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbWHRNrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbWHRNrx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 09:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbWHRNrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 09:47:51 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:10198 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751388AbWHRNru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 09:47:50 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Organization: IBM Deutschland Entwicklung GmbH
To: linuxppc-dev@ozlabs.org
Subject: Re: [2.6.19 PATCH 3/7] ehea: queue management
Date: Fri, 18 Aug 2006 15:47:46 +0200
User-Agent: KMail/1.9.1
Cc: Thomas Klein <osstklei@de.ibm.com>, Arjan van de Ven <arjan@infradead.org>,
       Thomas Klein <tklein@de.ibm.com>,
       Jan-Bernd Themann <themann@de.ibm.com>, netdev <netdev@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
References: <200608181331.19501.ossthema@de.ibm.com> <1155903451.4494.168.camel@laptopd505.fenrus.org> <44E5BFB7.4000400@de.ibm.com>
In-Reply-To: <44E5BFB7.4000400@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608181547.47081.arnd.bergmann@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 18 August 2006 15:25, Thomas Klein wrote:
> 
> > wow... is this really so large that it warrants a vmalloc()???
> 
> Agreed: Replaced with kmalloc()

My understanding from the previous discussion was that it actually
is a multi-page power of two allocation, so the right choice might
be __get_free_pages() instead of kmalloc, but it probably doesn't
make much of a difference.

You should really do some measurements to see what the minimal
queue sizes are that can get you optimal throughput.

	Arnd <><
