Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135506AbRAJNDs>; Wed, 10 Jan 2001 08:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135509AbRAJNDj>; Wed, 10 Jan 2001 08:03:39 -0500
Received: from dnscache.cbr.au.asiaonline.net ([210.215.8.100]:59626 "EHLO
	dnscache.cbr.au.asiaonline.net") by vger.kernel.org with ESMTP
	id <S135506AbRAJNDa>; Wed, 10 Jan 2001 08:03:30 -0500
Message-ID: <3A5C5D75.6E4425F6@valinux.com>
Date: Thu, 11 Jan 2001 00:02:45 +1100
From: Gareth Hughes <gareth@valinux.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Michael D. Crawford" <crawford@goingware.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: DRI doesn't work on 2.4.0 but does on prerelease-ac5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael D. Crawford wrote:
>
> glxinfo says dri is not available if I remove the library as I did. So I 
> rebuilt Mesa and reinstalled it. The full output of glxinfo on my machine 
> follows. Note that it says "direct rendering: Yes" but the version strings 
> don't match. Does that indicate the problem? 
> 
> Server: 1.3 Mesa 3.4 
> Client: 1.2 Mesa 3.4 
> OpenGL: 1.2 Mesa 3.4 
> 
> display: :0.0 screen:0 
> direct rendering: Yes 
> server glx vendor string: Brian Paul 
> server glx version string: 1.3 Mesa 3.4 
> server glx extensions: 
>     GLX_MESA_pixmap_colormap, GLX_EXT_visual_info, GLX_EXT_visual_rating, 
>     GLX_MESA_release_buffers, GLX_MESA_copy_sub_buffer, GLX_SGI_video_sync, 
>     GLX_ARB_get_proc_address 
> client glx vendor string: Brian Paul 
> client glx version string: 1.2 Mesa 3.4 
> client glx extensions: 
>     GLX_MESA_pixmap_colormap, GLX_EXT_visual_info, GLX_EXT_visual_rating, 
>     GLX_MESA_release_buffers, GLX_MESA_copy_sub_buffer, GLX_SGI_video_sync, 
>     GLX_ARB_get_proc_address 
> GLX extensions: 
>     GLX_MESA_pixmap_colormap, GLX_EXT_visual_info, GLX_EXT_visual_rating, 
>     GLX_MESA_release_buffers, GLX_MESA_copy_sub_buffer, GLX_SGI_video_sync, 
>     GLX_ARB_get_proc_address 
> OpenGL vendor string: Brian Paul 
> OpenGL renderer string: Mesa X11 
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> OpenGL version string: 1.2 Mesa 3.4 
> OpenGL extensions: 
>     ...

You are still using software Mesa.  It's not using the DRI libGL.so,
simple as that.

You should see something like this:

demos> glxinfo 
display: :0.0  screen:0
...
OpenGL vendor string: VA Linux Systems, Inc.
OpenGL renderer string: Mesa DRI Radeon 20010105 AGP 2x x86/3DNow!
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
OpenGL version string: 1.2 Mesa 3.4
OpenGL extensions:
    GL_ARB_multitexture, GL_ARB_tranpose_matrix, GL_EXT_abgr, 
    GL_EXT_blend_func_separate, GL_EXT_clip_volume_hint, 
    GL_EXT_compiled_vertex_array, GL_EXT_histogram,
GL_EXT_packed_pixels, 
    GL_EXT_polygon_offset, GL_EXT_rescale_normal, GL_EXT_stencil_wrap, 
    GL_EXT_texture3D, GL_EXT_texture_env_add,
GL_EXT_texture_env_combine, 
    GL_EXT_texture_env_dot3, GL_EXT_texture_object,
GL_EXT_texture_lod_bias, 
    GL_EXT_vertex_array, GL_MESA_window_pos, GL_MESA_resize_buffers, 
    GL_NV_texgen_reflection, GL_PGI_misc_hints, GL_SGIS_pixel_texture, 
    GL_SGIS_texture_edge_clamp
...

Try running with LIBGL_DEBUG=verbose set.  If you don't see the
following messages, you know for sure the DRI is not being used.

demos> LIBGL_DEBUG=verbose glxinfo
libGL: trying /usr/XF86/lib/modules/dri/radeon_dri.so
libGL: trying /usr/XF86/lib/modules/dri/radeon_dri.so
display: :0.0  screen:0
...

Try reading the DRI User's Guide at http://dri.sourceforge.net, or post
to dri-users@lists.sourceforge.net for help.  It just sounds like a
config problem, not a bug in the kernel, Mesa or the DRI.

-- Gareth
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
