Return-Path: <linux-kernel-owner+w=401wt.eu-S1753708AbWL1UIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708AbWL1UIp (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 15:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753720AbWL1UIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 15:08:45 -0500
Received: from gw-e.panasas.com ([65.194.124.178]:34007 "EHLO
	cassoulet.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753708AbWL1UIo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 15:08:44 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: Finding hardlinks
Date: Thu, 28 Dec 2006 15:07:43 -0500
Message-ID: <E472128B1EB43941B4E7FB268020C89B149CEC@riverside.int.panasas.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Finding hardlinks
Thread-Index: AccqrG654tBf+c5iRpK718nSKFnOjAACeeEo
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>  <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>  <20061221185850.GA16807@delft.aura.cs.cmu.edu>  <Pine.LNX.4.64.0612220038520.4677@artax.karlin.mff.cuni.cz> <1166869106.3281.587.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0612231458060.5182@artax.karlin.mff.cuni.cz> <4593890C.8030207@panasas.com> <4593C524.8070209@poochiereds.net> <4593DEF8.5020609@panasas.com> <Pine.LNX.4.64.0612281916230.2960@artax.karlin.mff.cuni.cz>
From: "Halevy, Benny" <bhalevy@panasas.com>
To: "Mikulas Patocka" <mikulas@artax.karlin.mff.cuni.cz>
Cc: "Jeff Layton" <jlayton@poochiereds.net>,
       "Arjan van de Ven" <arjan@infradead.org>,
       "Jan Harkes" <jaharkes@cs.cmu.edu>,
       "Miklos Szeredi" <miklos@szeredi.hu>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>, <nfsv4@ietf.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka wrote:
> 
>>> This sounds like a bug to me. It seems like we should have a one to one
>>> correspondence of filehandle -> inode. In what situations would this not be the
>>> case?
>>
>> Well, the NFS protocol allows that [see rfc1813, p. 21: "If two file handles from
>> the same server are equal, they must refer to the same file, but if they are not
>> equal, no conclusions can be drawn."]
>>
>> As an example, some file systems encode hint information into the filehandle
>> and the hints may change over time, another example is encoding parent
>> information into the filehandle and then handles representing hard links
>> to the same file from different directories will differ.
>
>BTW. how does (or how should?) NFS client deal with cache coherency if 
>filehandles for the same file differ?
>

Trond can probably answer this better than me...
As I read it, currently the nfs client matches both the fileid and the
filehandle (in nfs_find_actor). This means that different filehandles
for the same file would result in different inodes :(.
Strictly following the nfs protocol, comparing only the fileid should
be enough IF fileids are indeed unique within the filesystem.
Comparing the filehandle works as a workaround when the exported filesystem
(or the nfs server) violates that.  From a user stand point I think that
this should be configurable, probably per mount point.

>Mikulas
>
