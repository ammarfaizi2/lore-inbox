Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263396AbVCJXrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263396AbVCJXrO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 18:47:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263360AbVCJXog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 18:44:36 -0500
Received: from pat.uio.no ([129.240.130.16]:43745 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262972AbVCJXfw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 18:35:52 -0500
Subject: BK update for NFS client 2.6.11
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 10 Mar 2005 18:35:41 -0500
Message-Id: <1110497741.11175.7.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  Update of the NFS client. A lot of cleanups of the RPC auth code, but
also a couple of notable new features:
   - flock support for NFS.
   - Improved ESTALE recovery (Chuck + Al Viro).
   - NFSv4 network partition recovery code
   - bugfixes.

Cheers,
  Trond

----

Please do a

	bk pull bk://nfsclient.bkbits.net/linux-2.6

This will update the following files:

 fs/lockd/clntproc.c                   |   39 +-
 fs/lockd/host.c                       |    4 
 fs/locks.c                            |    9 
 fs/namei.c                            |   33 +
 fs/nfs/dir.c                          |  170 +++++----
 fs/nfs/file.c                         |   61 +++
 fs/nfs/inode.c                        |   48 ++
 fs/nfs/mount_clnt.c                   |    4 
 fs/nfs/nfs3proc.c                     |   76 +---
 fs/nfs/nfs4proc.c                     |  419 +++++++++++++++++-------
 fs/nfs/nfs4state.c                    |   76 +++-
 fs/nfs/nfs4xdr.c                      |   26 +
 fs/nfs/nfsroot.c                      |   13 
 fs/nfs/proc.c                         |   56 +--
 fs/nfs/read.c                         |    2 
 fs/nfs/unlink.c                       |    9 
 fs/nfs/write.c                        |   29 +
 fs/nfsd/nfs4callback.c                |    4 
 include/linux/lockd/lockd.h           |    3 
 include/linux/namei.h                 |    2 
 include/linux/nfs_fs.h                |   47 --
 include/linux/nfs_fs_sb.h             |    1 
 include/linux/nfs_xdr.h               |   12 
 include/linux/sunrpc/auth.h           |   19 -
 include/linux/sunrpc/auth_gss.h       |    7 
 include/linux/sunrpc/clnt.h           |    2 
 include/linux/sunrpc/gss_api.h        |   14 
 include/linux/sunrpc/sched.h          |    8 
 include/linux/sunrpc/xprt.h           |    3 
 net/sunrpc/auth.c                     |  185 ++++------
 net/sunrpc/auth_gss/auth_gss.c        |  586 +++++++++++++++++++---------------
 net/sunrpc/auth_gss/gss_krb5_mech.c   |  105 +++---
 net/sunrpc/auth_gss/gss_mech_switch.c |    8 
 net/sunrpc/auth_gss/gss_spkm3_mech.c  |  133 ++++---
 net/sunrpc/auth_gss/svcauth_gss.c     |    5 
 net/sunrpc/auth_null.c                |   60 +--
 net/sunrpc/auth_unix.c                |   74 ++--
 net/sunrpc/clnt.c                     |   43 +-
 net/sunrpc/pmap_clnt.c                |    5 
 net/sunrpc/sched.c                    |    7 
 net/sunrpc/xprt.c                     |    5 
 41 files changed, 1435 insertions(+), 977 deletions(-)

through these ChangeSets:

<trond.myklebust@fys.uio.no> (05/03/10 1.2075)
    NFS: Ensure "mount" is always interruptible and soft
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2074)
   NFS: cleanup create()
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2073)
   NFS: mkdir() cleanup
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2072)
   NFS: mknod() cleanup
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2071)
   NFSv4: in readdir, use MOUNTED_ON_FILEID, rather than true fileid
   
    Some servers return an error if the READDIR call attempts to read the
    fileid of a mountpoint.
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2070)
   NFSv4: Allow recovery from network partitions
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2069)
   NFSv4: Add nfs4_state_recovery_ops
   
    We want to reuse the same code to recover the NFSv4 state after a server
    reboot, a network partition, or a failover situation.
   
    Add a structure to contain those operations will that depend on the recovery
    scenario under consideration.
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2068)
   NFS: Cleanups for the network partition reclaim code
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2067)
   NFSv4: Fix access mode checking when opening a delegated file.
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2066)
   NFSv4: NFSv4 errors in nfs4_init_client() must not leak to userland
   
    Fixes a potential Oops at mount time.
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2065)
    NFSv4: Exit without Oopsing from close when servers send us crazy errors.
   
    If retrying the request is not an option, we should just set state->state
    and be done with it.
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2064)
    NFSv4: Handle the NFS4ERR_CLID_INUSE error in SETCLIENTID
   
    Encode the AUTH flavour in the clientid, since AUTH_UNIX and AUTH_GSS
    credentials will always conflict.
   
    Then, strategy is to first retry after sleeping for a lease period. If
    the server then still refuses our clientid, assume we have a conflicting
    client, out there, and try bumping a "uniquifier" variable.
   
    Give up if we're signalled, or if we've gone through the entire range
    of uniquifiers...
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2063)
   NFS: catch a few extra ESTALE errors that we are currently discarding.
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2062)
   VFS: Retry pathname resolution after encountering ESTALE
    
    Add a mechanism for the VFS layer to retry pathname resolution if a file
    system returns ESTALE at any point during the resolution process.  Pathname
    resolution is retried once from the first component, using all real lookup
    requests.
   
    This provides effective recovery for most cases where files or directories
    have been replaced by other remote file system clients.  It also provides
    a foundation to build a mechanism by which file system clients can fail
    over transparently to a replicated server.
   
    Test-plan:
    Combinations of rsync and "ls -l" on multiple clients.  No stale file handles
    should be after directory trees are replaced.  Standard performance tests;
    little or no loss of performance is expected.
   
    Created: Fri, 11 Feb 2005 16:46:19 -0500
    
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2061)
   NFS,RPC: RPC client now advertises maximum payload size
   
    The RPC client now reports the maximum payload size supported by the chosen
    transport method.  This is something a little less than 64KB for RPC over
    UDP, and about 2GB - 1 for RPC over TCP.  The effective rsize and wsize
    values are not allowed to exceed the reported maximum RPC payload size.
   
    Signed-off-by: Chuck Lever <cel@netapp.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2060)
   RPC: remove broken_suid mount option
   
   Remove broken_suid mount option (retry RPC after dropping privileges
   upon EACCES): no longer used and questionable w.r.t. security.
   
    Signed-off-by: Frank van Maarseveen <frankvm@frankvm.com>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2059)
   [NLM] fs/lockd/clntproc.c: make 2 functions static
   
    This patch makes two needlessly global functions static.
   
    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2058)
   NFS: This patch makes some needlessly global code static.
   
    Signed-off-by: Adrian Bunk <bunk@stusta.de>
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2057)
   RPC: Clean up of rpcauth_lookupcred() and rpcauth_bindcred()
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2056)
   RPC: make rpcauth_lookupcred() return error codes.
   
    So we can distinguish between ENOMEM and EACCES errors.
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2055)
   RPC: Initialize the GSS context upon RPC credential creation.
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2054)
   RPC: Remove dependency of RPCSEC_GSS upcalls on the credential cache
   
    Ensure that credentials that are referenced by an RPC task, but that
    have been booted out of the credcache may still be refreshed.
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2053)
   RPCSEC_GSS: Enable expiring of credentials
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2052)
   RPCSEC_GSS: Misc little cleanups.
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2051)
   RPCSEC_GSS: cleanup gss_cred.
   
    gc_flavor is used only for looking up the security service, which is an
    integer value that never changes. Store the latter instead of the former.
   
    Fix up a couple of dodgy casts between gss_cred and rpc_cred. Replace them
    with the appropriate container_of().
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2050)
   RPC: Document the format of the gssd downcalls
   
    - Document the format of the gssd downcalls
    - Separate out "uid" field from rest of GSS context data struct
      since it will not be needed for the keyring-based contexts.
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2049)
   RPC: clean up the RPCSEC_GSS kerberos and spkm3 context import functions
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2048)
   NLM: Always use AUTH_UNIX authentication for NLM locking.
   
    Most existing servers do not implement RPCSEC_GSS for either the lockd or
    statd daemons.
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2047)
   NFS: Add emulation of BSD flock() in terms of POSIX locks on the server
   
    This makes for an interesting situation in which programs compiled
    to use flock() and running on the server will not see the locks that
    are set by the clients. The clients will, however, see both POSIX and
    flock() locks set by other clients.
   
    It is the best you can do, given the limitations of the protocol.
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2046)
   VFS: Fix structure initialization in locks_remove_flock()
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2045)
   RPC: Shrink struct rpc_auth for those flavours that don't use the cache
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2044)
   RPC: Unify the AUTH_UNIX credential cache.
   
    AUTH_UNIX credentials really only depend on the process uid/gid/groups
    information. In particular there is no dependency on any strict rpc_client
    specific information. Might as well share them all between all RPC clients.
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2043)
   RPC: Unify AUTH_NULL credentials
   
    There is only one AUTH_NULL "credential".
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2042)
   RPC: Convert RPC credcache to use hlists
   
    This will make initialization of statically allocated caches simpler.
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2041)
   RPC: kill cr_auth
   
    The cr_auth field is currently used only in order to figure out the name
    of the credential's flavour in debugging printks. Replace with a dedicated
    pointer in the statically allocated rpc_credops instead.
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2040)
   RPC: Make rpc_auth credential cache optional.
   
     Some RPC authentication flavours are not related to the uid (AUTH_NULL
     springs to mind). This patch moves control over the caching mechanism
     into the auth-specific code.
   
     Also ensure that expired creds are removed from the cache.
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2039)
   RPC: Move credcache-specific code out of put_rpccred()
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2038)
   RPC: struct rpc_auth initialization and destruction code cleanup
   
    Move the initialization of auth->au_count into the flavour-specific code.
    Move the kfree(auth) into the flavour-specific code.
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2037)
   RPC: Remove unnecessary reference counting in gss downcall code.
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2036)
   RPC: Remove unnecessary module refcounting
   
    The sunrpc module itself is referenced by other sources, so only the
    auth_gss credcaches need to increment their module refcount.
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2035)
   RPC: Some portmappers expect AUTH_UNIX authentication
   
    Sun's RPC library portmap client therefore defaults to AUTH_UNIX. Change our
    in-kernel client to follow that convention.
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2034)
   RPC: Fix return value of rpc_call_async()
   
    RPC call async is supposed to return an error if and only if
    it failed to run the rpc_task.
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2033)
   NFS: Use sizeof() instead of strlen() on string constants.
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2032)
   RPC: Don't kill timers when calling rpc_restart_call() after rpc_delay()
   
    Currently, if we restart an RPC call after having set an RPC delay (for
    instance in the case where an NFS EJUKEBOX error has occurred) the call
    to rpc_delete_timer() at the top of the rpc_execute() loop will
    kill off our timer.
   
    This patch causes rpc_delete_timer() to detect if the rpc_task is still
    queued on a wait queue, and refuse to delete the timer if this is the case.
   
    Problem diagnosed by Jan Sanislo and Olaf Kirch.
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2031)
    NFS: Fix refcount leakage in nfs4_proc_create()
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>

<trond.myklebust@fys.uio.no> (05/03/10 1.2030)
   NFS: Clean up nfs_permission().
   
    Fix a bug whereby we are failing to test for permissions on opendir().
    Optimize away permissions checks that request MAY_WRITE on directories.
    Ensure that VFS sets LOOKUP_CONTINUE before calling permission().
   
    Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>


-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

