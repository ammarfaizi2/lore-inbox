Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261230AbVDTIew@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbVDTIew (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 04:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVDTIew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 04:34:52 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:55788 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S261230AbVDTIeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 04:34:50 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
Date: Wed, 20 Apr 2005 08:34:48 +0000 (UTC)
Organization: Cistron
Message-ID: <d45478$npo$1@news.cistron.nl>
References: <Pine.LNX.4.61.0504180726320.3232@chimarrao.boston.redhat.com> <4266062B.9060400@lab.ntt.co.jp> <20050420075031.GA31785@taniwha.stupidest.org> <42660B6B.6040600@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1113986088 24376 194.109.0.112 (20 Apr 2005 08:34:48 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@cistron.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <42660B6B.6040600@lab.ntt.co.jp>,
Takashi Ikebe  <ikebe.takashi@lab.ntt.co.jp> wrote:
>Chris Wedgwood wrote:
>> On Wed, Apr 20, 2005 at 04:35:07PM +0900, Takashi Ikebe wrote:> 
>> 
>>>To takeover the application status, connection type
>>>communications(SOCK_STREAM) are need to be disconnected by close().
>>>Same network port is not allowed to bind by multiple processes....
>> 
>> 
>> AF_UNIX socket with SCM_RIGHTS
>> 
>hmm.. most internet base services will use TCPv4 TCPv6 SCTP...
>AF_UNIX can not use as inter-nodes communication.

No, Chris means filedescriptor passing.

You can pass any existing open filedescriptor to another process
using an AF_UNIX socket.

For example, the existing running process creates a UNIX socket in
/var/run/mysocket that the new process can connect() to. The
processes can then not only exchange all kinds of information,
the old process can even send open filedescriptors over to
the new process without closing/re-opening.

See "man 7 unix", ANCILLARY MESSAGES -> SCM_RIGHTS

ANCILLARY MESSAGES
       Ancillary data is sent and received using  sendmsg(2)  and  recvmsg(2).
       For  historical  reasons  the  ancillary message types listed below are
       specified with a SOL_SOCKET type even though they are PF_UNIX specific.
       To  send  them  set  the  cmsg_level  field  of  the  struct cmsghdr to
       SOL_SOCKET and the cmsg_type field to the type.  For  more  information
       see cmsg(3).


       SCM_RIGHTS
              Send or receive a set of open file descriptors from another pro-
              cess.  The data portion contains an integer array  of  the  file
              descriptors.   The passed file descriptors behave as though they
              have been created with dup(2).

Mike.

